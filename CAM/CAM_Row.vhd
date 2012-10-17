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


entity CAM_Row is
		Generic (CAM_WIDTH : integer := 8) ;
		Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           search_word : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           dont_care_mask : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           row_match : out  STD_LOGIC);
end CAM_Row;

architecture Binary_Cam_Row of CAM_Row is


component CAM_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end component ;

for all : CAM_Cell use entity work.CAM_Cell(Binary_Cam_Cell); 

signal cell_matches : std_logic_vector(CAM_WIDTH-1 downto 0); 
begin

-- Connect the CAM cells here
Init_Cell: CAM_Cell
	port map(
		clk => clk, 
		rst => rst,
		we => we,
		cell_search_bit => search_word(0),
		cell_dont_care_bit => dont_care_mask(0),
		cell_match_bit_in => '1', 
		cell_match_bit_out => cell_matches(0)
		); 
		
gen_loop: for N in 1 to CAM_WIDTH-1 generate 
	dict_unit: CAM_Cell
		port map(
			clk => clk,
			rst => rst, 
			we => we,
			cell_search_bit => search_word(N),
			cell_dont_care_bit => dont_care_mask(N),
			cell_match_bit_in => cell_matches(N-1), 
			cell_match_bit_out => cell_matches(N)
			); 
	end generate; 
row_match <= cell_matches(CAM_WIDTH-1);
end Binary_Cam_Row;


architecture Std_Ternary_St_Cam_Row of CAM_Row is
component CAM_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end component ;

for all : CAM_Cell use entity work.CAM_Cell(Std_Ternary_St_Cam); 

signal cell_matches : std_logic_vector(CAM_WIDTH-1 downto 0); 
begin

--Connect the CAM cells here
Init_Cell: CAM_Cell
	port map(
		clk => clk, 
		rst => rst,
		we => we,
		cell_search_bit => search_word(0),
		cell_dont_care_bit => dont_care_mask(0),
		cell_match_bit_in => '1', 
		cell_match_bit_out => cell_matches(0)
		); 
		
gen_loop: for N in 1 to CAM_WIDTH-1 generate 
	dict_unit: CAM_Cell
		port map(
			clk => clk,
			rst => rst, 
			we => we,
			cell_search_bit => search_word(N),
			cell_dont_care_bit => dont_care_mask(N),
			cell_match_bit_in => cell_matches(N-1), 
			cell_match_bit_out => cell_matches(N)
			); 
	end generate;
row_match <= cell_matches(CAM_WIDTH-1);	
end Std_Ternary_St_Cam_Row;

architecture Ternary_at_Input_Row of CAM_Row is
component CAM_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end component ;

for all : CAM_Cell use entity work.CAM_Cell(Ternary_at_Input_Cell); 

signal cell_matches : std_logic_vector(CAM_WIDTH-1 downto 0); 
begin

-- Connect the CAM cells here
Init_Cell: CAM_Cell
	port map(
		clk => clk, 
		rst => rst,
		we => we,
		cell_search_bit => search_word(0),
		cell_dont_care_bit => dont_care_mask(0),
		cell_match_bit_in => '1', 
		cell_match_bit_out => cell_matches(0)
		); 
		
gen_loop: for N in 1 to CAM_WIDTH-1 generate 
	dict_unit: CAM_Cell
		port map(
			clk => clk,
			rst => rst, 
			we => we,
			cell_search_bit => search_word(N),
			cell_dont_care_bit => dont_care_mask(N),
			cell_match_bit_in => cell_matches(N-1), 
			cell_match_bit_out => cell_matches(N)
			); 
	end generate; 
	
	row_match <= cell_matches(CAM_WIDTH-1); 
end Ternary_at_Input_Row;