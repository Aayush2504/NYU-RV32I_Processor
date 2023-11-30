library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProgramCounter_tb is
-- Testbench entity does not have ports
end ProgramCounter_tb;

architecture behavior of ProgramCounter_tb is 

    component ProgramCounter
    port(
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        pc_out : out STD_LOGIC_VECTOR(31 downto 0)
    );
    end component;

    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal pc_out : STD_LOGIC_VECTOR(31 downto 0);
    signal expected_pc : STD_LOGIC_VECTOR(31 downto 0);

begin
    uut: ProgramCounter
        port map (
            clk => clk,
            reset => reset,
            pc_out => pc_out
        );

    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns; -- Clock period is 20 ns
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Testbench statements
    stim_proc: process
    begin
        -- Initialize expected PC value
        expected_pc <= x"40000000";

        -- Test Case 1: Check initial value after reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;
        assert pc_out = expected_pc
        report "Test Case 1 Failed: PC did not reset to the start address."
        severity error;

        -- Test Case 2: Increment PC
        -- Allow a few clock cycles for the PC to increment
        expected_pc <= expected_pc + std_logic_vector(to_unsigned(12, 32)); -- Increment by 12 (3 cycles * 4)
        wait for 60 ns;
        assert pc_out = expected_pc
        report "Test Case 2 Failed: PC did not increment correctly."
        severity error;

        -- Test Case 3: Assert reset and check PC reset
        reset <= '1';
        expected_pc <= x"40000000"; -- Reset expected PC
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;
        assert pc_out = expected_pc
        report "Test Case 3 Failed: PC did not reset after assert."
        severity error;

        -- Test Case 4: Observe PC increment again
        expected_pc <= expected_pc + std_logic_vector(to_unsigned(8, 32)); -- Increment by 8 (2 cycles * 4)
        wait for 40 ns;
        assert pc_out = expected_pc
        report "Test Case 4 Failed: PC did not increment after reset."
        severity error;

        -- Test Case 5: Additional reset check
        reset <= '1';
        expected_pc <= x"40000000"; -- Reset expected PC
        wait for 20 ns;
        reset <= '0';
        wait for 100 ns;
        assert pc_out = expected_pc
        report "Test Case 5 Failed: Additional reset check failed."
        severity error;

        -- End the test
        wait;
    end process;

end behavior;
