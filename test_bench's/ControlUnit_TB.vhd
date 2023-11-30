library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControlUnit_tb is
    -- Test bench entity, no ports needed
end ControlUnit_tb;

architecture Behavioral of ControlUnit_tb is
    -- Component declaration for the ControlUnit
    component ControlUnit
        Port (
            instruction : in STD_LOGIC_VECTOR(31 downto 0);
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
            rd: inout STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    -- Signals for interfacing with the ControlUnit
    signal instruction : STD_LOGIC_VECTOR(31 downto 0);
    signal opcode : STD_LOGIC_VECTOR(6 downto 0);
    signal funct3 : STD_LOGIC_VECTOR(2 downto 0);
    signal aluOp : STD_LOGIC_VECTOR(2 downto 0);
    signal memRead, memWrite, regWrite, branch, jal, jalr, aluSrc, memToReg : STD_LOGIC;
    signal regDst : STD_LOGIC_VECTOR(4 downto 0);
    signal rd : STD_LOGIC_VECTOR(4 downto 0);

begin
    -- Instantiate the ControlUnit
    uut: ControlUnit port map (
        instruction => instruction,
        opcode => opcode,
        funct3 => funct3,
        aluOp => aluOp,
        memRead => memRead,
        memWrite => memWrite,
        regWrite => regWrite,
        branch => branch,
        jal => jal,
        jalr => jalr,
        aluSrc => aluSrc,
        memToReg => memToReg,
        regDst => regDst,
        rd => rd
    );

    -- Test process
    process
    begin
        -- Test Case 1: Testing an ADD instruction
        instruction <= (others => '0'); -- Set a 32-bit instruction for ADD
        wait for 10 ns;
        assert aluOp = "000" and regWrite = '1' and memRead = '0' and memWrite = '0'
            report "Test Case 1 failed for ADD instruction" severity error;

        -- Test Case 2: Testing a LOAD instruction
        instruction <= (others => '0'); -- Set a 32-bit instruction for LOAD
        wait for 10 ns;
        assert aluOp = "000" and regWrite = '1' and memRead = '1' and memWrite = '0'
            report "Test Case 2 failed for LOAD instruction" severity error;
    
        -- Test Case 3: Testing a STORE instruction
        instruction <= (others => '0'); -- Set a 32-bit instruction for STORE
        wait for 10 ns;
        assert aluOp = "000" and regWrite = '0' and memRead = '0' and memWrite = '1'
            report "Test Case 3 failed for STORE instruction" severity error;
    
        -- Test Case 4: Testing a BEQ (Branch if Equal) instruction
        instruction <= (others => '0'); -- Set a 32-bit instruction for BEQ
        wait for 10 ns;
        assert branch = '1' and aluOp = "001" and regWrite = '0'
            report "Test Case 4 failed for BEQ instruction" severity error;
    
        -- Test Case 5: Testing a JALR (Jump and Link Register) instruction
        instruction <= (others => '0'); -- Set a 32-bit instruction for JALR
        wait for 10 ns;
    
        -- Test Case 6: Testing a SLTI (Set Less Than Immediate) instruction
        instruction <= (others => '0'); -- Set a 32-bit instruction for SLTI
        wait for 10 ns;
    
        -- Test Case 7: Testing a SLTIU (Set Less Than Immediate Unsigned) instruction
        instruction <= (others => '0'); -- Set a 32-bit instruction for SLTIU
        wait for 10 ns;
    
        -- Test Case 8: Testing a XORI (XOR Immediate) instruction
        instruction <= (others => '0'); -- Set a 32-bit instruction for XORI
        wait for 10 ns;
    
        -- Test Case 9: Testing an ORI (OR Immediate) instruction
        instruction <= (others => '0'); -- Set a 32-bit instruction for ORI
        wait for 10 ns;
    
        -- Test Case 10: Testing an ANDI (AND Immediate) instruction
        instruction <= (others => '0'); -- Set a 32-bit instruction for ANDI
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
