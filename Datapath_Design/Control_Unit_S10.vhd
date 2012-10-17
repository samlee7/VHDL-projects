----------------------------------------------------
-- Name: Sam Lee, John Enriquez
-- Email: slee103@ucr.edu, jenri002@ucr.edu
-- Lab Section: 022
-- Assignment: Lab 3
-- I acknowledge all content is original
----------------------------------------------------
------------------
-- Design of MIPS Controller
------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.MIPS_LIB.all;

entity Control is
  port(
    rst : in std_logic;
    clk : in std_logic;
    alu_src_A  : out std_logic;
    alu_src_B  : out std_logic_vector( 1 downto 0 );
    alu_op     : out std_logic_vector( 1 downto 0 );
    reg_write  : out std_logic;
    reg_dst    : out std_logic;
    pc_source  : out std_logic_vector( 1 downto 0 );
	 pc_write_cond: out std_logic;
    pc_write    : out std_logic;
    i_or_d     : out std_logic;
    mem_read   : out std_logic;
    mem_write  : out std_logic;
    mem_to_reg : out std_logic;
    IR_write   : out std_logic;
    ins_31_26 : in std_logic_vector( 5 downto 0 );
    alu_zero  : in std_logic
    );

end Control;

architecture bhv of Control is

  type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9);
  signal state, next_state : state_type;
  
  
  signal s_mem_read : std_logic;
  signal s_alu_src_a : std_logic;
  signal s_i_or_d : std_logic;
  signal s_ir_write : std_logic;
  signal s_alu_src_b : std_logic_vector(1 DOWNTO 0);
  signal s_alu_op : std_logic_vector(1 DOWNTO 0);
  signal s_pc_write : std_logic;
  signal s_pc_src : std_logic_vector(1 DOWNTO 0);
  signal s_pc_write_cond : std_logic;
  signal s_reg_write : std_logic;
  signal s_reg_dst : std_logic;
  signal s_mem_write : std_logic;
  signal s_mem_to_reg : std_logic;
  
-- will be defined in "mips_lib.vhd"
-- constant LW     : std_logic_vector( 5 downto 0 ) := "100011";
-- constant SW     : std_logic_vector( 5 downto 0 ) := "101011";
-- constant RTYPE  : std_logic_vector( 5 downto 0 ) := "000000";
-- constant BEQ    : std_logic_vector( 5 downto 0 ) := "000100";
-- constant JUMP   : std_logic_vector( 5 downto 0 ) := "000010";
-- constant DONE   : std_logic_vector( 5 downto 0 ) := "111111";


begin
	
	mem_read <= s_mem_read;
	alu_src_a <= s_alu_src_A;
	i_or_d <= s_i_or_d;
	IR_write <= s_IR_write;
	alu_src_B <= s_alu_src_b;
	alu_op <= s_alu_op;
	pc_source <= s_pc_src;
	pc_write_cond <= s_pc_write_cond;
	reg_write <= s_reg_write;
	reg_dst <= s_reg_dst;
	mem_write <= s_mem_write;
	mem_to_reg <= s_mem_to_reg;
	
  process (rst, clk)
  begin

    if (clk = '1' and clk'event) then
      state <= next_state;

    end if;

  end process;

  process (clk, rst, ins_31_26, alu_zero, state)
  begin

    if (rst = '1') then
    	next_state <= S0;
	  
    else
			case state is
			  
			when S0 =>	
				next_state <= S1;	
				
			
			when S1 =>
				
				if (ins_31_26 = LW) then 
					next_state <= S2;	
					
				elsif (ins_31_26 = SW) then 
					next_state <= S2;	 
					
				elsif (ins_31_26 = RTYPE) then 
					next_state <= S6;
					
				elsif (ins_31_26 = BEQ) then 
					next_state <= S8;
					
				elsif (ins_31_26 = JUMP) then 
					next_state <= S9;
					
				else
					next_state <= S0;  
					
				end if;
					
			when S2 =>
				if(ins_31_26 = LW) then
					next_state <= S3;					
				elsif (ins_31_26 = SW) then
					next_state <= S5;	
				else
					next_state <= S0 ;
				end if;
			
			when S3 =>	
				next_state <= S4;	
			
			when S4 => 
				next_state <= S0;	
			
			when S5 => 
				next_state <= S0;	
			
			when S6 =>
				next_state <= S7;			
			
			when S7 =>	
				next_state <= S0;	
			
			when S8 =>	
				next_state <= S0;	
			
			when S9 =>
				next_state <= S0;	

			end case;
		 
     end if;

end process;	

process (clk, rst, ins_31_26, alu_zero, state, s_pc_write_cond, s_pc_write)
	  begin
	  
	  pc_write <= s_pc_write OR (alu_zero AND s_pc_write_cond);
	  pc_write_cond <= s_pc_write_cond;
	  
	  case state is
			  when S0 =>	
				s_mem_read <= '1';
				s_alu_src_A <= '0';
				s_i_or_d <= '0';		
				s_IR_write <= '1';
				s_alu_src_B <= "01";
				s_alu_op <= "00";
				s_pc_write <= '1';
				s_pc_src <= "00";
				s_pc_write_cond <= '0';
				s_reg_write <= '0';
				s_reg_dst <= '0';
				s_mem_write <= '0';
				s_mem_to_reg <= '0';
				
				
			when S1 =>
				s_mem_read <= '0';
				s_alu_src_A <= '0';
				s_i_or_d <= '0';		
				s_IR_write <= '0';
				s_alu_src_B <= "11";
				s_alu_op <= "00";
				s_pc_write <= '0';
				s_pc_src <= "00";
				s_pc_write_cond <= '0';
				s_reg_write <= '0';
				s_reg_dst <= '0';
				s_mem_write <= '0';
				s_mem_to_reg <= '0';
							
			when S2 =>
				s_mem_read <= '0';
				s_alu_src_A <= '1';
				s_i_or_d <= '0';		
				s_IR_write <= '0';
				s_alu_src_B <= "10";
				s_alu_op <= "00";
				s_pc_write <= '0';
				s_pc_src <= "00";
				s_pc_write_cond <= '0';
				s_reg_write <= '0';
				s_reg_dst <= '0';
				s_mem_write <= '0';
				s_mem_to_reg <= '0';
							
				
			when S3 =>	
				s_mem_read <= '1';
				s_alu_src_A <= '0';
				s_i_or_d <= '1';		
				s_IR_write <= '0';
				s_alu_src_B <= "00";
				s_alu_op <= "00";
				s_pc_write <= '0';
				s_pc_src <= "00";
				s_pc_write_cond <= '0';
				s_reg_write <= '0';
				s_reg_dst <= '0';
				s_mem_write <= '0';
				s_mem_to_reg <= '0';
							
				
			when S4 => 
				s_mem_read <= '0';
				s_alu_src_A <= '0';
				s_i_or_d <= '0';		
				s_IR_write <= '0';
				s_alu_src_B <= "00";
				s_alu_op <= "00";
				s_pc_write <= '0';
				s_pc_src <= "00";
				s_pc_write_cond <= '0';
				s_reg_write <= '1';
				s_reg_dst <= '0';
				s_mem_write <= '0';
				s_mem_to_reg <= '1';

			
			when S5 => 
				s_mem_read <= '0';
				s_alu_src_A <= '0';
				s_i_or_d <= '1';		
				s_IR_write <= '0';
				s_alu_src_B <= "00";
				s_alu_op <= "00";
				s_pc_write <= '0';
				s_pc_src <= "00";
				s_pc_write_cond <= '0';
				s_reg_write <= '0';
				s_reg_dst <= '0';
				s_mem_write <= '1';
				s_mem_to_reg <= '0';
							
			
			
			when S6 =>
				s_mem_read <= '0';
				s_alu_src_A <= '1';
				s_i_or_d <= '0';		
				s_IR_write <= '0';
				s_alu_src_B <= "00";
				s_alu_op <= "10";
				s_pc_write <= '0';
				s_pc_src <= "00";
				s_pc_write_cond <= '0';
				s_reg_write <= '0';
				s_reg_dst <= '0';
				s_mem_write <= '0';
				s_mem_to_reg <= '0';
							
			
			when S7 =>
				s_mem_read <= '0';
				s_alu_src_A <= '0';
				s_i_or_d <= '0';		
				s_IR_write <= '0';
				s_alu_src_B <= "00";
				s_alu_op <= "00";
				s_pc_write <= '0';
				s_pc_src <= "00";
				s_pc_write_cond <= '0';
				s_reg_write <= '1';
				s_reg_dst <= '1';
				s_mem_write <= '0';
				s_mem_to_reg <= '0';
							
		
			when S8 =>	
				s_mem_read <= '0';
				s_alu_src_A <= '1';
				s_i_or_d <= '0';		
				s_IR_write <= '0';
				s_alu_src_B <= "00";
				s_alu_op <= "01";
				s_pc_write <= '0';
				s_pc_src <= "01";
				s_pc_write_cond <= '1';
				s_reg_write <= '0';
				s_reg_dst <= '0';
				s_mem_write <= '0';
				s_mem_to_reg <= '0';
							
			when S9 =>
				s_mem_read <= '0';
				s_alu_src_A <= '0';
				s_i_or_d <= '0';		
				s_IR_write <= '0';
				s_alu_src_B <= "00";
				s_alu_op <= "00";
				s_pc_write <= '1';
				s_pc_src <= "10";
				s_pc_write_cond <= '0';
				s_reg_write <= '0';
				s_reg_dst <= '0';
				s_mem_write <= '0';
				s_mem_to_reg <= '0';
							
				
		when others=>
				s_mem_read <= '0' ;
				s_alu_src_A <= '0' ;
				s_i_or_d <= '0' ;		
				s_IR_write <= '0' ;
				s_alu_src_B <= "00" ;
				s_alu_op <= "00" ;
				s_pc_write <= '1' ;
				s_pc_src <= "10" ;
				s_pc_write_cond <= '0' ;
				s_reg_write <= '0' ;
				s_reg_dst <= '0' ;
				s_mem_write <= '0' ;
				s_mem_to_reg <= '0' ;
		end case;  

  end process;	
  
end bhv;


