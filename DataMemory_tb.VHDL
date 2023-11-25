library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory_tb is
-- Empty entity as this is a testbench
end InstructionMemory_tb;

architecture Behavioral of InstructionMemory_tb is
    -- Component Declaration for the InstructionMemory
    component InstructionMemory
        Port (
            clk : in std_logic;
            addr : in std_logic_vector(31 downto 0);
            instr : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals for interfacing with the InstructionMemory component
    signal clk_tb : std_logic := '0';
    signal addr_tb : std_logic_vector(31 downto 0) := (others => '0');
    signal instr_tb : std_logic_vector(31 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: InstructionMemory
        Port map (
            clk => clk_tb,
            addr => addr_tb,
            instr => instr_tb
        );

    -- Clock process definitions
    clk_process : process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;

    -- Test process
    stim_proc: process
    begin
        -- Test with different addresses
        addr_tb <= "00000000000000000000000000000000"; -- Address 0
        wait for clk_period * 2;

        addr_tb <= "00000000000000000000000000000100"; -- Address 1
        wait for clk_period * 2;

        addr_tb <= "00000000000000000000000000001000"; -- Address 2
        wait for clk_period * 2;

        -- Add more addresses as needed for testing

        -- End simulation
        wait;
    end process;

end Behavioral;
