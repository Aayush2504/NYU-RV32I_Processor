library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory_tb is
-- Testbench entity does not have ports
end InstructionMemory_tb;

architecture behavior of InstructionMemory_tb is 

    component InstructionMemory
    port(
        clk : in std_logic;
        addr : in std_logic_vector(31 downto 0);
        instr : out std_logic_vector(31 downto 0)
    );
    end component;

    signal clk : std_logic := '0';
    signal addr : std_logic_vector(31 downto 0) := (others => '0');
    signal instr : std_logic_vector(31 downto 0);

begin
    uut: InstructionMemory
        port map (
            clk => clk,
            addr => addr,
            instr => instr
        );

    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns; -- Clock period is 20 ns
        clk <= '1';
        wait for 10 ns;
    end process;

    stim_proc: process
    begin
        -- Test Case 1: Check first instruction
        addr <= std_logic_vector(to_unsigned(0, 32));
        wait for 20 ns;
        assert instr = "00000000010000001000000010110111"
        report "Test Case 1 Failed: Incorrect instruction fetched."
        severity error;

        -- Test Case 2: Check second instruction
        addr <= std_logic_vector(to_unsigned(4, 32)); -- Byte address 4 (Word-aligned)
        wait for 20 ns;
        assert instr = "00000000010100010000000100010111"
        report "Test Case 2 Failed: Incorrect instruction fetched."
        severity error;

        -- Test Case 3: Check third instruction
        addr <= std_logic_vector(to_unsigned(8, 32)); -- Byte address 8
        wait for 20 ns;
        assert instr = "00000000000000010011000011101111"
        report "Test Case 3 Failed: Incorrect instruction fetched."
        severity error;

        -- Test Case 4: Check a non-initialized instruction (should be all zeros)
        addr <= std_logic_vector(to_unsigned(40, 32)); -- An address beyond initialized instructions
        wait for 20 ns;
        assert instr = (others => '0')
        report "Test Case 4 Failed: Non-initialized instruction is not all zeros."
        severity error;

        -- Test Case 5: Check another initialized instruction
        addr <= std_logic_vector(to_unsigned(20, 32)); -- Byte address 20
        wait for 20 ns;
        assert instr = "00000000110001111011111100110011"
        report "Test Case 5 Failed: Incorrect instruction fetched."
        severity error;

        -- End the test
        wait;
    end process;

end behavior;
