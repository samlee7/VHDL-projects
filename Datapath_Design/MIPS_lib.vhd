----------------------------------------------------
-- Name: Sam Lee, John Enriquez
-- Email: slee103@ucr.edu, jenri002@ucr.edu
-- Lab Section: 022
-- Assignment: Lab 3
-- I acknowledge all content is original
----------------------------------------------------
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;

-------------------------------------------------------------------------------

package MIPS_LIB is

    constant CD_32    : std_logic_vector (31 downto 0) := "--------------------------------";
    constant CD_26    : std_logic_vector (25 downto 0) := "--------------------------";
    constant CD_16    : std_logic_vector (15 downto 0) := "----------------";
    constant CD_6     : std_logic_vector (5 downto 0) := "------";
    constant CD_5     : std_logic_vector (4 downto 0) := "-----";
    constant C0_32    : std_logic_vector (31 downto 0) := "00000000000000000000000000000000";
    constant CM_32    : std_logic_vector (31 downto 0) := "11111111111111111111111111111111";
    constant C1_32    : std_logic_vector (31 downto 0) := "00000000000000000000000000000001";
    constant C4_32    : std_logic_vector (31 downto 0) := "00000000000000000000000000000100";
    constant C128_32  :	std_logic_vector (31 downto 0) := "00000000000000000000000010000000";

    constant C0_16    : std_logic_vector (15 downto 0) := "0000000000000000";
    constant CM_16    : std_logic_vector (15 downto 0) := "1111111111111111";

-- opcodes
    
    constant LW     : std_logic_vector( 5 downto 0 ) := "100011";
    constant SW     : std_logic_vector( 5 downto 0 ) := "101011";
    constant RTYPE  : std_logic_vector( 5 downto 0 ) := "000000";
    constant BEQ    : std_logic_vector( 5 downto 0 ) := "000100";
    constant JUMP   : std_logic_vector( 5 downto 0 ) := "000010";
    constant DONE   : std_logic_vector( 5 downto 0 ) := "111111";

-- Registers
    constant zero : std_logic_vector( 4 downto 0 ) := "00000";  -- always zero
    constant at   : std_logic_vector( 4 downto 0 ) := "00001";  
    constant v0   : std_logic_vector( 4 downto 0 ) := "00010";  
    constant v1   : std_logic_vector( 4 downto 0 ) := "00011"; 
    constant a0   : std_logic_vector( 4 downto 0 ) := "00100"; 
    constant a1   : std_logic_vector( 4 downto 0 ) := "00101"; 
    constant a2   : std_logic_vector( 4 downto 0 ) := "00110"; 
    constant a3   : std_logic_vector( 4 downto 0 ) := "00111"; 
    constant t0   : std_logic_vector( 4 downto 0 ) := "01000";
    constant t1   : std_logic_vector( 4 downto 0 ) := "01001";	
    constant t2   : std_logic_vector( 4 downto 0 ) := "01010";
    constant t3   : std_logic_vector( 4 downto 0 ) := "01011";
    constant t4   : std_logic_vector( 4 downto 0 ) := "01100";
    constant t5   : std_logic_vector( 4 downto 0 ) := "01101";
    constant t6   : std_logic_vector( 4 downto 0 ) := "01110";
    constant t7   : std_logic_vector( 4 downto 0 ) := "01111";
    constant s0   : std_logic_vector( 4 downto 0 ) := "10000";
    constant s1   : std_logic_vector( 4 downto 0 ) := "10001";	
    constant s2   : std_logic_vector( 4 downto 0 ) := "10010";
    constant s3   : std_logic_vector( 4 downto 0 ) := "10011";
    constant s4   : std_logic_vector( 4 downto 0 ) := "10100";
    constant s5   : std_logic_vector( 4 downto 0 ) := "10101";
    constant s6   : std_logic_vector( 4 downto 0 ) := "10110";
    constant s7   : std_logic_vector( 4 downto 0 ) := "10111";
    constant t8   : std_logic_vector( 4 downto 0 ) := "11000"; 
    constant t9   : std_logic_vector( 4 downto 0 ) := "11001";
    constant k0   : std_logic_vector( 4 downto 0 ) := "11010";
    constant k1   : std_logic_vector( 4 downto 0 ) := "11011"; 
    constant gp   : std_logic_vector( 4 downto 0 ) := "11100";
    constant sp   : std_logic_vector( 4 downto 0 ) := "11101";
    constant fp   : std_logic_vector( 4 downto 0 ) := "11110";
    constant ra   : std_logic_vector( 4 downto 0 ) := "11111"; 
	
end MIPS_LIB;

-------------------------------------------------------------------------------
-- end of file --
