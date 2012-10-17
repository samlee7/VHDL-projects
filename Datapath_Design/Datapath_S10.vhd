----------------------------------------------------
-- Name: Sam Lee, John Enriquez
-- Email: slee103@ucr.edu, jenri002@ucr.edu
-- Lab Section: 022
-- Assignment: Lab 3
-- I acknowledge all content is original
----------------------------------------------------
-- Datapath
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.MIPS_LIB.all;

entity Datapath is
    port(
	 
	rst : in std_logic;
	clk : in std_logic;
        --control signals
	alu_src_A : in std_logic;
	alu_src_B : in std_logic_vector( 1 downto 0 );
        -- output from the ALU control 
	alu_control : in std_logic_vector( 2 downto 0 );
	reg_write : in std_logic;
	reg_dst : in std_logic;
	pc_source : in std_logic_vector( 1 downto 0 );
        -- output from the or gate, combining PCWriteCond and PCWrite
   pc_write : in std_logic;
	i_or_d : in  std_logic;
	mem_read : in std_logic;
	mem_write : in std_logic;
	mem_to_reg : in std_logic;
	IR_write : in  std_logic;
        
        -- output to controller
	ins_31_26 : out std_logic_vector( 5 downto 0 );
        -- output to ALU control
   ins_5_0   : out std_logic_vector( 5 downto 0 );
        -- output to PC write logic
   alu_zero   : out std_logic;

        -- used for testing
   testing_alu_result    : out std_logic_vector(31 downto 0);
   testing_mem_data : out std_logic_vector(31 downto 0);
   testing_read_data_1  : out std_logic_vector(31 downto 0);
   testing_read_data_2  : out std_logic_vector(31 downto 0) );
    
end Datapath;

-- purpose: connect all the components
architecture bhv of Datapath is

component Generic_Register
generic ( NUMBITS : integer := 32) ;
  port(
      rst   : in std_logic;
      clk   : in std_logic;
      load : in std_logic;
      input : in std_logic_vector (31 downto 0);
      output: out std_logic_vector (31 downto 0)
      );
end component;

  
component Mux_32_2_1
    port(
	sel 	: in std_logic;
	input_a	: in std_logic_vector(31 downto 0);
	input_b	: in std_logic_vector(31 downto 0);
	output	: out std_logic_vector(31 downto 0)
	);
end component;

component Mux_5_2_1
    port(
	sel 	: in std_logic;
	input_a	: in std_logic_vector(4 downto 0);
	input_b	: in std_logic_vector(4 downto 0);
	output	: out std_logic_vector(4 downto 0)
	);
end component;

component Mux_32_4_1
    port(
	sel 	: in std_logic_vector(1 downto 0);
	input_a	: in std_logic_vector(31 downto 0);
	input_b	: in std_logic_vector(31 downto 0);
        input_c	: in std_logic_vector(31 downto 0);
        input_d	: in std_logic_vector(31 downto 0);
	output	: out std_logic_vector(31 downto 0)
	);
end component;

component Mux_32_3_1
    port(
	sel 	: in std_logic_vector(1 downto 0);
	input_a	: in std_logic_vector(31 downto 0);
	input_b	: in std_logic_vector(31 downto 0);
	input_c	: in std_logic_vector(31 downto 0);
	output	: out std_logic_vector(31 downto 0)
	);
end component;

component my_MEM_256x32
    port( 
	clka       	: in  std_logic;
	dina       	: in  std_logic_vector (31 downto 0);
	addra    	: in  std_logic_vector (7 downto 0);
	wea        	: in  std_logic;
	douta   	: out std_logic_vector (31 downto 0)
	);
end component;

component Reg_File
    port ( 
	rst        : in std_logic;
	clk        : in std_logic;
	reg_write  : std_logic;
	read_reg_1  : in std_logic_vector(4 downto 0);
	read_reg_2  : in std_logic_vector(4 downto 0);
	write_reg  : in std_logic_vector(4 downto 0);
	write_data : in std_logic_vector(31 downto 0);
	read_data_1 : out std_logic_vector(31 downto 0);
	read_data_2 : out std_logic_vector(31 downto 0)
	);
end component;

component SignExt_16_32
    port(
	input	: in std_logic_vector(15 downto 0);
	output	: out std_logic_vector(31 downto 0)
	);
end component;

component ALU
    port(
	input_a    : in std_logic_vector( 31 downto 0);
	input_b    : in std_logic_vector( 31 downto 0 );
	operation  : in std_logic_vector( 2 downto 0 );	
	zero       : out std_logic;
	result     : out std_logic_vector( 31 downto 0 )
	);
end component;


-- memory address, connect to output of MUX
signal address   : std_logic_vector(31 downto 0);
-- data to write to memory, connect to output of B register
signal mem_write_data : std_logic_vector(31 downto 0);
-- data read from Memory, connect to input of IR and MDR
signal mem_data   : std_logic_vector(31 downto 0);

-- value going into and coming out of PC register
signal new_pc           : std_logic_vector(31 downto 0);
signal pc               : std_logic_vector(31 downto 0);

-- output from IR
signal instr            : std_logic_vector(31 downto 0);
signal instr_25_0         : std_logic_vector(25 downto 0);
signal instr_31_26        : std_logic_vector(5 downto 0);
signal instr_25_21        : std_logic_vector(4 downto 0);
signal instr_20_16        : std_logic_vector(4 downto 0);
signal instr_15_11        : std_logic_vector(4 downto 0);
signal instr_5_0          : std_logic_vector(5 downto 0);
signal instr_15_0         : std_logic_vector(15 downto 0);
signal instr_out			  : std_logic_vector(31 downto 0);

-- output from Memory Data Register
signal MDR_out            : std_logic_vector(31 downto 0);

-- inputs to register file
signal write_reg           : std_logic_vector( 4 downto 0);
signal RF_write_data          : std_logic_vector(31 downto 0);

-- output from register file
signal read_data_1          : std_logic_vector(31 downto 0);
signal read_data_2          : std_logic_vector(31 downto 0);

-- output from A and B register
signal reg_A_out            : std_logic_vector(31 downto 0);
signal reg_B_out            : std_logic_vector(31 downto 0);

-- constant 4, used as input to mux
signal four               : std_logic_vector(31 downto 0);

-- sign extender output
signal sign_ext_out         : std_logic_vector(31 downto 0);
-- sign extender output shift left twice
signal sign_ext_out_SL2     : std_logic_vector(31 downto 0);

-- ALU inputs and output
signal alu_input_A        : std_logic_vector(31 downto 0);
signal alu_input_B        : std_logic_vector(31 downto 0);
signal alu_result        : std_logic_vector(31 downto 0);

-- output from ALUOut register
signal alu_out           : std_logic_vector(31 downto 0);

-- input to 3 to 1 PC Mux
signal jump_addr         : std_logic_vector(31 downto 0);

signal temp_instr_sl2 	 : std_logic_vector(27 downto 0);

begin  -- bhv
	
	-- testing
	testing_alu_result <= alu_result;
   testing_mem_data <= mem_data;
   testing_read_data_1  <= read_data_1;
   testing_read_data_2 <= read_data_2;

	instr_25_0 <= instr(25 downto 0);
	instr_31_26 <= instr(31 downto 26);
	instr_25_21 <= instr(25 downto 21);
	instr_20_16 <= instr(20 downto 16);
	instr_15_11 <= instr(15 downto 11);
	instr_5_0 <= instr(5 downto 0);
	instr_15_0 <= instr(15 downto 0);
	
	ins_31_26 <= instr_31_26;
	
	temp_instr_sl2 <= instr_25_0 & "00";
	
	jump_addr <= pc(31 downto 28) & temp_instr_sl2;
	
	four <= conv_std_logic_vector(4,32);
	
	ins_5_0 <= instr_5_0;
	
	sign_ext_out_SL2 <= sign_ext_out(29 downto 0) & "00";

  -- PC REGISTER
	U_PCREG: Generic_Register 	
		generic map (NUMBITS => 32)
		port map (
			rst => rst,
         clk => clk,
         load => pc_write,
         input => new_pc,
         output => pc
		);

	-- MUX taking data from PC
	PCtoMux :  Mux_32_2_1
		port map(
			sel => i_or_d, 
			input_a => pc,
			input_b => alu_out,
			output => address
		);

	--Global memory unit taking from PC->MUX
	Memory_Unit :  my_MEM_256x32
		port map( 
			clka => clk,
			dina => reg_B_out,
			addra => address(7 downto 0),
			wea => mem_write,
			douta => mem_data
	);
	
	-- MEMORY DATA REGISTER
	Mem_Data_Reg: Generic_Register 	
		generic map (NUMBITS => 32)
		port map (
			rst => rst,
         clk => clk,
         load => '1',
         input => mem_data,
         output => MDR_out
		);
		
	Inst_Reg : Generic_Register 	
		generic map (NUMBITS => 32)
		port map (
			rst => rst,
         clk => clk,
         load => IR_write,
         input => mem_data,
         output => instr
		);
		
	
	MUXtoWRITEREG : Mux_5_2_1
		port map(
			sel => reg_dst,
			input_a => instr_20_16,
			input_b => instr_15_11,
			output => write_reg
		);
		
	MUXtoWRITEDATA : Mux_32_2_1
		port map(
			sel => mem_to_reg,
			input_a => alu_out,
			input_b => MDR_out,
			output => RF_write_data
		);
	
	Register_File : Reg_File
		port map ( 
			rst => rst,
			clk => clk,
			reg_write => reg_write,
			read_reg_1 => instr_25_21,
			read_reg_2 => instr_20_16,
			write_reg  => write_reg,
			write_data => RF_write_data,
			read_data_1 => read_data_1,
			read_data_2 => read_data_2
		);
		
	SigEx16_32 : SignExt_16_32
		port map(
			input => instr_15_0,
			output => sign_ext_out
		);
	
	Reg_A : Generic_Register 	
		generic map (NUMBITS => 32)
		port map (
			rst => rst,
         clk => clk,
         load => '1',
         input => read_data_1,
         output => reg_A_out
		);
	
	Reg_B : Generic_Register 	
		generic map (NUMBITS => 32)
		port map (
			rst => rst,
         clk => clk,
         load => '1',
         input => read_data_2,
         output => reg_B_out
		);
		
	MUXtoALUa : Mux_32_2_1
		port map(
			sel => alu_src_A,
			input_a => pc,
			input_b => reg_A_out,
			output => alu_input_A
		);
	
	MUXtoALUb : Mux_32_4_1
		port map(
			sel => alu_src_B,
			input_a => reg_B_out,
			input_b => four,
			input_c => sign_ext_out,
			input_d => sign_ext_out_SL2,
			output => alu_input_B
		);
		
	the_alu : ALU
		port map(
			input_a => alu_input_A,
			input_b => alu_input_B,
			operation => alu_control,
			zero => alu_zero,
			result => alu_result
		);
	
	alu_result_reg : Generic_Register 	
		generic map (NUMBITS => 32)
		port map (
			rst => rst,
         clk => clk,
         load => '1',
         input => alu_result,
         output => alu_out
		);
		
	MUXtoPC : Mux_32_3_1
		port map(
			sel => pc_source,
			input_a => alu_result,
			input_b => alu_out,
			input_c => jump_addr,
			output => new_pc
		);

end bhv;
