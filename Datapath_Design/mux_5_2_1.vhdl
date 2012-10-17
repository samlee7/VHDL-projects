----------------------------------------------------
-- Name: Sam Lee, John Enriquez
-- Email: slee103@ucr.edu, jenri002@ucr.edu
-- Lab Section: 022
-- Assignment: Lab 3
-- I acknowledge all content is original
----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_5_2_1 is
    Port ( sel : in  STD_LOGIC;
           input_a : in  STD_LOGIC_VECTOR (4 downto 0);
           input_b : in  STD_LOGIC_VECTOR (4 downto 0);
           output : out  STD_LOGIC_VECTOR (4 downto 0));
end Mux_5_2_1;

architecture Behavioral of Mux_5_2_1 is

begin

process(sel,input_a,input_b)
begin
	if (sel='1') then
		output <= input_b;
	else
		output <= input_a;
	end if;
end process;

end Behavioral;

