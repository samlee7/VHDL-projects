----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:17:32 04/06/2012 
-- Design Name: 
-- Module Name:    alu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity my_ALU is
	generic(
		NUMBITS	: natural	:= 4
	);
	port(
		A			: in  std_logic_vector(NUMBITS-1 downto 0);
		B			: in  std_logic_vector(NUMBITS-1 downto 0);
		opcode	: in  std_logic_vector(2 downto 0);
		result	: out std_logic_vector(NUMBITS-1 downto 0);
		carryout	: out std_logic;
		overflow	: out std_logic;
		zero		: out std_logic
	);
end my_ALU;

architecture Behavioral of my_alu is

--Enter Signals used here
signal result_sig : std_logic_vector(NUMBITS-1 downto 0);
constant ZEROS : std_logic_vector(NUMBITS-1 downto 0):= (others => '0');
signal extended_A : std_logic_vector(NUMBITS downto 0);
signal extended_B : std_logic_vector(NUMBITS downto 0);
begin


--Enter Processes used here
	hdlalu : process (A,B,opcode, result_sig)
		begin
		carryout<='0';
		overflow<='0';
		zero<='0';
		if (A = ZEROS AND B = ZEROS) then
			zero <= '1';
			result_sig <= ZEROS;
		elsif (opcode = "000") then
			result_sig <= (A + B);
			if((result_sig < A) OR (result_sig < B)) then
				carryout <= '1';
				overflow <= '1';
			end if;
		elsif(opcode = "001") then
			result_sig <= A + B;
			if((A >= ZEROS) AND (B >= ZEROS) AND (result_sig < ZEROS)) then
				overflow <= '1';
			elsif ((A < ZEROS) AND (B < ZEROS) AND (result_sig >= ZEROS)) then
				overflow <= '1';
			end if;
		elsif(opcode = "010") then
			result_sig <= A - B;
		elsif(opcode = "011") then
			result_sig <= A - B;
			if((A >= ZEROS) AND (B < ZEROS) AND (result_sig < ZEROS)) then
				overflow <= '1';
			elsif ((A < ZEROS) AND (B >= ZEROS) AND (result_sig >= ZEROS)) then
				overflow <= '1';
			end if;
		elsif(opcode = "100") then
			result_sig <= (A AND B);
		elsif(opcode = "101") then
			result_sig <= (A OR B);
		elsif(opcode = "110") then
			result_sig <= (A XOR B);
		elsif(opcode = "111") then
			result_sig <= ('0' & A(NUMBITS-1 downto 1));
		end if;
	if(result_sig=ZEROS) then
		zero<='1';
	end if;
	result<=result_sig(NUMBITS-1 downto 0);
	--carryout<=result_sig(NUMBITS);
	end process  hdlalu;
	
end Behavioral;


