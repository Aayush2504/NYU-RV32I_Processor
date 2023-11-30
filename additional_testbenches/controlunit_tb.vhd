library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControlUnit_tb is
end ControlUnit_tb;

architecture Behavioral of ControlUnit_tb is
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal instruction : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal opcode : STD_LOGIC_VECTOR(6 downto 0);
    signal funct3 : STD_LOGIC_VECTOR(2 downto 0);
    signal aluOp : STD_LOGIC_VECTOR(2 downto 0);
    signal memRead, memWrite, regWrite, branch, jal, jalr, aluSrc, memToReg : STD_LOGIC;
    signal regDst : STD_LOGIC_VECTOR(4 downto 0);
    signal rd : STD_LOGIC_VECTOR(4 downto 0) := "00000";

begin
    -- Instantiate the ControlUnit entity
    UUT : entity work.ControlUnit
        port map (
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

    -- Clock process
    process
    begin
        wait for 5 ns;  -- Adjust the simulation time as needed
        clk <= not clk;
    end process;

    -- Stimulus process
    process
    begin
        wait for 10 ns;  -- Initial wait to stabilize signals
        rst <= '1';      -- Assert reset
        wait for 5 ns;
        rst <= '0';      -- De-assert reset

        -- Test 1: LUI instruction
        instruction <= "00000000000000000000000001101111";
        wait for 10 ns;

        -- Test 2: AUIPC instruction
        instruction <= "00000000000000000000000000101111";
        wait for 10 ns;

        -- Add more test cases as needed

        wait;
    end process;

end Behavioral;
