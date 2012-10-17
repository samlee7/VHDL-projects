----------------------------------------------------
-- Name: Sam Lee, John Enriquez
-- Email: slee103@ucr.edu, jenri002@ucr.edu
-- Lab Section: 022
-- Assignment: Lab 3
-- I acknowledge all content is original
----------------------------------------------------
-------------------------------------------------------------------------------
-- ALU
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
use work.MIPS_LIB.all;

entity ALU is
    port(
	input_a    : in std_logic_vector( 31 downto 0);
	input_b    : in std_logic_vector( 31 downto 0 );
	operation  : in std_logic_vector( 2 downto 0 );	
	zero       : out std_logic;
	result     : out std_logic_vector( 31 downto 0 )
	);
end ALU;

architecture bhv of ALU is
begin
    process( input_a, input_b, operation ) 
	variable temp_result : std_logic_vector( 31 downto 0 );

        constant ALU_AND : STD_LOGIC_VECTOR(2 downto 0) := "000";
        constant ALU_OR  : STD_LOGIC_VECTOR(2 downto 0) := "001";
        constant ALU_ADD : STD_LOGIC_VECTOR(2 downto 0) := "010";
        constant ALU_SUB : STD_LOGIC_VECTOR(2 downto 0) := "110";
        constant ALU_LT  : STD_LOGIC_VECTOR(2 downto 0) := "111";
        
    begin	
	case operation is
	    when ALU_AND => temp_result := input_a and input_b;
	    when ALU_OR  => temp_result := input_b or input_a;
            when ALU_ADD => temp_result := input_a + input_b;
	    when ALU_SUB => temp_result := input_a - input_b;		
	    when ALU_LT  => 
		if ( input_a < input_b ) then
		    temp_result := C1_32;
		else
		    temp_result := C0_32;
		end if;	
	
	    when others => temp_result := C0_32;
	end case;				   
		
	if( temp_result = C0_32 ) then
	    zero <= '1';
	else
	    zero <= '0';
	end if;
	
	result <= temp_result;
	
    end process;
end bhv;
