library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory_tb is
-- Testbench has an empty entity
end DataMemory_tb;

architecture Behavioral of DataMemory_tb is
    -- Component Declaration for the DataMemory
    component DataMemory
        Port ( 
            clk : in STD_LOGIC;
            addr : in STD_LOGIC_VECTOR (31 downto 0);
            data_in : in STD_LOGIC_VECTOR (31 downto 0);
            mem_read : in STD_LOGIC;
            mem_write : in STD_LOGIC;
            data_out : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;

    -- Signals for interfacing with the DataMemory component
    signal clk_tb : std_logic := '0';
    signal addr_tb : std_logic_vector(31 downto 0) := (others => '0');
    signal data_in_tb : std_logic_vector(31 downto 0) := (others => '0');
    signal mem_read_tb : std_logic := '0';
    signal mem_write_tb : std_logic := '0';
    signal data_out_tb : std_logic_vector(31 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: DataMemory
        Port map (
            clk => clk_tb,
            addr => addr_tb,
            data_in => data_in_tb,
            mem_read => mem_read_tb,
            mem_write => mem_write_tb,
            data_out => data_out_tb
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
        -- Test Writing to RAM
        addr_tb <= x"00000001"; -- Normal address
        data_in_tb <= x"12345678";
        mem_write_tb <= '1';
        wait for clk_period * 2;

        mem_write_tb <= '0'; -- Disable write
        wait for clk_period;

        -- Test Reading from RAM
        mem_read_tb <= '1';
        wait for clk_period * 2;

        mem_read_tb <= '0'; -- Disable read
        wait for clk_period;

        -- Test Reading from Special Read-Only Address
        addr_tb <= x"00100000"; -- Special read-only address
        mem_read_tb <= '1';
        wait for clk_period * 2;

        -- Add more tests as needed

        -- End simulation
        wait;
    end process;
end Behavioral;
