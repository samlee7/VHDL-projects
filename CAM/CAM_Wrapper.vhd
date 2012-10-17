
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity CAM_Wrapper is
	Generic (CAM_WIDTH : integer := 8 ;
				CAM_DEPTH : integer := 8 ) ;
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we_decoded_row_address : in  STD_LOGIC_VECTOR (CAM_DEPTH-1 downto 0);
           search_word : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           dont_care_mask : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           decoded_match_address : out  STD_LOGIC_VECTOR (CAM_DEPTH-1 downto 0));
end CAM_Wrapper;




architecture Behavioral of CAM_Wrapper is

component CAM_Array is
	Generic (CAM_WIDTH : integer := 8 ;
				CAM_DEPTH : integer := 4 ) ;
	Port (  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  we_decoded_row_address : in STD_LOGIC_VECTOR(CAM_DEPTH-1 downto 0) ;
           search_word : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           dont_care_mask : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           decoded_match_address : out  STD_LOGIC_VECTOR (CAM_DEPTH-1 downto 0));
end  component ;


signal rst_buffered : STD_LOGIC ;
signal we_decoded_row_address_buffered : STD_LOGIC_VECTOR(CAM_DEPTH-1 downto 0) ;
signal search_word_buffered, dont_care_mask_buffered : STD_LOGIC_VECTOR(CAM_WIDTH-1 downto 0) ;
signal decoded_match_address_sig, decoded_match_address_buffered : STD_LOGIC_VECTOR(CAM_DEPTH-1 downto 0) ;


begin


decoded_match_address <= decoded_match_address_buffered ;

process(clk, rst, we_decoded_row_address, search_word, dont_care_mask, decoded_match_address_sig)
begin 

if(clk'event and clk='1')then
	rst_buffered <= rst ;
	we_decoded_row_address_buffered <= we_decoded_row_address ;
	search_word_buffered <= search_word ;
	dont_care_mask_buffered <= dont_care_mask ;
	decoded_match_address_buffered <= decoded_match_address_sig ;
end if ;

end process ;


CAM_Array_pmX: CAM_Array generic map ( 
   CAM_WIDTH => CAM_WIDTH,
   CAM_DEPTH => CAM_DEPTH 
)
port map (
   clk => clk ,
   rst => rst_buffered ,
   we_decoded_row_address => we_decoded_row_address_buffered ,
   search_word => search_word_buffered ,
   dont_care_mask => dont_care_mask_buffered ,
   decoded_match_address => decoded_match_address_sig
);

end Behavioral;

