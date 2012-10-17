----------------------------------------------------
-- Name: Sam Lee, John Enriquez
-- Email: slee103@ucr.edu, jenri002@ucr.edu
-- Lab Section: 022
-- Assignment: Lab 3
-- I acknowledge all content is original
----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Reg_File is
    port ( 
	rst        : in std_logic;
	clk        : in std_logic;
	reg_write  : in std_logic;
	read_reg_1  : in std_logic_vector(4 downto 0);
	read_reg_2  : in std_logic_vector(4 downto 0);
	write_reg  : in std_logic_vector(4 downto 0);
	write_data : in std_logic_vector(31 downto 0);
	read_data_1 : out std_logic_vector(31 downto 0);
	read_data_2 : out std_logic_vector(31 downto 0)
	);		
end Reg_File;

architecture Behavioral of Reg_File is

type registers_type is array(0 to 31) of std_logic_vector(31 downto 0);
signal registers : registers_type ;


begin
	process(rst, clk)
		begin
			if( rst = '1' ) then
				for i in 0 to 31 loop
					registers(i) <= x"00000000";
				end loop;
			elsif( clk'event and clk = '1') then
				read_data_1 <= registers(conv_integer(read_reg_1));
				read_data_2 <= registers(conv_integer(read_reg_2));
				if( reg_write = '1' ) then
					registers(conv_integer(write_reg)) <= write_data;
				end if;
			end if;
	end process;
	

end Behavioral;