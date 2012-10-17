--Names: Sam Lee, Dinuk Kurukulasooriya
--Login: slee103, dkuru001
--Email: slee103@ucr.edu, dkuru001@ucr.edu
--Lab Section: 022
--Assignment: Lab 6
--I acknowledge all content is original.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CAM_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end CAM_Cell;

architecture Binary_Cam_Cell of CAM_Cell is

signal sb_sig : std_logic:='0';
begin

Register_ff: process (clk, rst, we, cell_search_bit)
begin
    if clk'event and clk='1' then
        if rst='1' then 
            sb_sig<='0';
        else
            if we='1' then
                sb_sig<=cell_search_bit;
				else 
					-- do nothing 
            end if;
        end if;
    end if;
end process Register_ff;

Binary_cell_lg : process(cell_search_bit, cell_match_bit_in, sb_sig)
begin 
	cell_match_bit_out <= (cell_search_bit xnor sb_sig) and cell_match_bit_in ; 

end process Binary_cell_lg; 
end Binary_Cam_Cell; 

architecture Std_Ternary_St_Cam of CAM_Cell is
signal sb_sig : std_logic:='0';
signal sb_sig2: std_logic:='0'; 
begin 
Register_ff: process (clk, rst, we, cell_search_bit)
begin
    if clk'event and clk='1' then
        if rst='1' then 
            sb_sig<='0';
        else
            if we='1' then
                sb_sig<=cell_search_bit;
				else 
					 --do nothing 
            end if;
        end if;
    end if;
end process Register_ff;

Register_ff_dc : process(clk, rst, we, cell_dont_care_bit)
begin 
	if clk'event and clk ='1' then 
		if rst = '1' then 
			sb_sig2 <= '0'; 
		else 
			if we = '1' then 
				sb_sig2<= cell_dont_care_bit; 
			else 
				 --do nothing 
			end if; 
		end if; 
	end if; 
end process Register_ff_dc; 

Std_Ternary_lg : process(cell_search_bit, cell_match_bit_in, sb_sig, sb_sig2)
begin 
cell_match_bit_out <= ((cell_search_bit xnor sb_sig )and cell_match_bit_in ) or sb_sig2; 

end process Std_Ternary_lg; 
end Std_Ternary_St_Cam; 


architecture Ternary_at_Input_Cell of CAM_Cell is
signal sb_sig : std_logic:='0';
begin

Register_ff: process (clk, rst, we, cell_search_bit)
begin
    if clk'event and clk='1' then
        if rst='1' then 
            sb_sig<='0';
        else
            if we='1' then
                sb_sig<=cell_search_bit;
				else 
					-- do nothing 
            end if;
        end if;
    end if;
end process Register_ff;

Ternary_lg: process( cell_search_bit, cell_match_bit_in, sb_sig, cell_dont_care_bit)
begin 
cell_match_bit_out <= ((cell_search_bit xnor sb_sig) and cell_match_bit_in ) or cell_dont_care_bit; 
end process Ternary_lg; 
end Ternary_at_Input_Cell ;







