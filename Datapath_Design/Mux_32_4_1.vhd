----------------------------------------------------
-- Name: Sam Lee, John Enriquez
-- Email: slee103@ucr.edu, jenri002@ucr.edu
-- Lab Section: 022
-- Assignment: Lab 3
-- I acknowledge all content is original
----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux_32_4_1 is
    Port ( sel : in  STD_LOGIC_VECTOR (1 downto 0);
           input_a : in  STD_LOGIC_VECTOR (31 downto 0);
           input_b : in  STD_LOGIC_VECTOR (31 downto 0);
           input_c : in  STD_LOGIC_VECTOR (31 downto 0);
           input_d : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux_32_4_1;

architecture Behavioral of Mux_32_4_1 is

begin

process(sel,input_a,input_b,input_c,input_d)

begin
	if sel="00" then
		output <= input_a;
	elsif sel="01" then
		output <= input_b;
	elsif sel="10" then
		output <= input_c;
	else
		output <= input_d;
	end if;
end process;

end Behavioral;

