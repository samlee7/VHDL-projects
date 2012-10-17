----------------------------------------------------
-- Name: Sam Lee, John Enriquez
-- Email: slee103@ucr.edu, jenri002@ucr.edu
-- Lab Section: 022
-- Assignment: Lab 3
-- I acknowledge all content is original
----------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity ALUControl is
    port(
		alu_op 		: in std_logic_vector( 1 downto 0 );
    	ins_5_0   	: in std_logic_vector( 5 downto 0 );
        alu_control : out std_logic_vector( 2 downto 0 )
        );
    
end ALUControl;

architecture bhv of ALUControl is

begin  -- bhv
	process (alu_op, ins_5_0)
		variable alu_control_out_temp : std_logic_vector( 2 downto 0 );
	begin
	
		if ( alu_op = "00" ) then
			alu_control_out_temp := "010";
		elsif (alu_op = "01" ) then 
			alu_control_out_temp := "110";
			
		else
			case ins_5_0( 3 downto 0) is
				when "0000" => 
					alu_control_out_temp := "010";
				
				when "0010" =>
					alu_control_out_temp := "110";
				
				when "0100" =>
					alu_control_out_temp := "000";
				
				when "0101" =>
					alu_control_out_temp := "001";
				
				when "1010" =>
					alu_control_out_temp := "111";
				
				when others =>
					alu_control_out_temp := "000";
				
			end case;
			
		end if;								
		
		alu_control <= alu_control_out_temp;
  	end process;

end bhv;
