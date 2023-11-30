library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControlUnit is
    Port ( instruction : in STD_LOGIC_VECTOR(31 downto 0);
           opcode : out STD_LOGIC_VECTOR(6 downto 0);
           funct3 : out STD_LOGIC_VECTOR(2 downto 0);
           aluOp : out STD_LOGIC_VECTOR(2 downto 0);
           memRead : out STD_LOGIC;
           memWrite : out STD_LOGIC;
           regWrite : out STD_LOGIC;
           branch : out STD_LOGIC;
           jal : out STD_LOGIC;
           jalr : out STD_LOGIC;
           aluSrc : out STD_LOGIC;
           memToReg : out STD_LOGIC;
           regDst : out STD_LOGIC_VECTOR(4 downto 0);
           rd: inout STD_LOGIC_VECTOR(4 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is
    signal state : integer := 0;
    signal opcode_var : STD_LOGIC_VECTOR(6 downto 0);

begin
    process(instruction)
    begin
        case state is
            when 0 =>
                -- Fetch opcode and set next state
                opcode_var <= instruction(6 downto 0);
                state <= 1;
                
            when 1 =>
                -- Decode based on opcode
                case opcode_var is
		when "0110111" =>
		-- Set control signals for LUI
		funct3 <= "000";
		aluOp <= "000";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= "00000";
		
		when "0010111" =>
		-- Set control signals for AUIPC
		funct3 <= "000";
		aluOp <= "000";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= "00000";
		
		when "1101111" =>
		-- Set control signals for JAL
		
		funct3 <= "000";
		aluOp <= "011";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '1';
		jal <= '1';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= "00000";
		when "1100111" =>
		-- Set control signals for JALR
		funct3 <= "000";
		aluOp <= "000";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '1';
		jal <= '1';
		jalr <= '1';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= "00000";
		
		
		when "1100011" =>
		-- Set control signals for BEQ
		funct3 <= "000";
		aluOp <= "001";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '0';
		branch <= '1';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= "00000";
		
		when "1100011" =>
		-- Set control signals for BNE
		funct3 <= "001";
		aluOp <= "001";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '0';
		branch <= '1';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= "00000";
		when "1100011" =>
		-- Set control signals for BLT
		funct3 <= "100";
		aluOp <= "100";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '0';
		branch <= '1';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= "00000";
		when "1100011" =>
		-- Set control signals for BGE
		funct3 <= "101";
		aluOp <= "101";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '0';
		branch <= '1';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= "00000";
		when "1100011" =>
		-- Set control signals for BLTU
		funct3 <= "110";
		aluOp <= "110";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '0';
		branch <= '1';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= "00000";
		when "1100011" =>
		-- Set control signals for BGEU
		funct3 <= "111";
		aluOp <= "111";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '0';
		branch <= '1';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= "00000";
		when "0000011" =>
		
		-- Set control signals for LB
		funct3 <= "000";
		aluOp <= "000";
		memRead <= '1';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '1';
		regDst <= "00000";
		when "0000011" =>
		
		-- Set control signals for LBU
		funct3 <= "100";
		aluOp <= "100";
		memRead <= '1';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '1';
		regDst <= "00000";
		
		when "0000011" =>
		
		-- Set control signals for LHU
		funct3 <= "101";
		aluOp <= "101";
		memRead <= '1';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '1';
		regDst <= "00000";
		when "0100011" =>
		-- Set control signals for SB
		funct3 <= "000";
		aluOp <= "000";
		memRead <= '0';
		memWrite <= '1';
		regWrite <= '0';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= "00000";
		when "0100011" =>
		
		-- Set control signals for SH
		funct3 <= "001";
		aluOp <= "001";
		memRead <= '0';
		memWrite <= '1';
		regWrite <= '0';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= "00000";
		when "0100011" =>
		
		-- Set control signals for SW
		funct3 <= "010";
		aluOp <= "010";
		memRead <= '0';
		memWrite <= '1';
		regWrite <= '0';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= "00000";
		when "0010011" =>
		
		-- Set control signals for ADDI
		funct3 <= "000";
		aluOp <= "000";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= rd;
		when "0010011" =>
		-- Set control signals for SLTI
		funct3 <= "010";
		aluOp <= "010";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= rd;
		
		when "0010011" =>
		-- Set control signals for SLTIU
		funct3 <= "011";
		aluOp <= "011";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= rd;
		when "0010011" =>
		
		-- Set control signals for XORI
		funct3 <= "100";
		aluOp <= "100";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= rd;
		when "0010011" =>
		-- Set control signals for ORI
		funct3 <= "110";
		aluOp <= "110";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= rd;
		when "0010011" =>
		-- Set control signals for ANDI
		funct3 <= "111";
		aluOp <= "111";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '1';
		memToReg <= '0';
		regDst <= rd;
		
		when "0010011" =>
		-- Set control signals for SLLI
		funct3 <= "001";
		aluOp <= "001";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0010011" =>
		-- Set control signals for SRLI
		funct3 <= "101";
		aluOp <= "101";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0010011" =>
		-- Set control signals for SRAI
		funct3 <= "101";
		aluOp <= "101";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0110011" =>
		-- Set control signals for ADD
		funct3 <= "000";
		aluOp <= "000";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0110011" =>
		-- Set control signals for SUB
		funct3 <= "000";
		aluOp <= "000";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0110011" =>
		-- Set control signals for SLL
		funct3 <= "001";
		aluOp <= "001";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0110011" =>
		-- Set control signals for SLT
		funct3 <= "010";
		aluOp <= "010";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		
		when "0110011" =>
		-- Set control signals for SLTU
		funct3 <= "011";
		aluOp <= "011";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0110011" =>
		-- Set control signals for XOR
		funct3 <= "100";
		aluOp <= "100";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0110011" =>
		-- Set control signals for SRL
		funct3 <= "101";
		aluOp <= "101";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0110011" =>
		-- Set control signals for SRA
		funct3 <= "101";
		aluOp <= "101";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0110011" =>
		
		-- Set control signals for OR
		funct3 <= "110";
		aluOp <= "110";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0110011" =>
		-- Set control signals for AND
		funct3 <= "111";
		aluOp <= "111";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '1';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= rd;
		when "0001111" =>
		-- Set control signals for FENCE
		funct3 <= "000";
		aluOp <= "000";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '0';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= "00000";
		when "1110011" =>
		-- Set control signals for ECALL
		funct3 <= "000";
		aluOp <= "000";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '0';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= "00000";
		when "1110011" =>
		-- Set control signals for EBREAK
		funct3 <= "001";
		aluOp <= "001";
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '0';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= "00000";
		
		when others =>
		-- Default case
		
		-- Default case
		-- Handle undefined opcode (set default values or raise an error)
		aluOp <= "000";   -- Default ALU operation
		memRead <= '0';
		memWrite <= '0';
		regWrite <= '0';
		branch <= '0';
		jal <= '0';
		jalr <= '0';
		aluSrc <= '0';
		memToReg <= '0';
		regDst <= "00000"; -- Default destination register
		when others=>
		report "Error"
    -- You can add additional error handling or logging here

                end case;
        end case;
    end process;
end Behavioural;
