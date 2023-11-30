library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory_tb is
end DataMemory_tb;

architecture behavior of DataMemory_tb is 

    component DataMemory
    port(
        clk : in STD_LOGIC;
        addr : in STD_LOGIC_VECTOR(31 downto 0);
        data_in : in STD_LOGIC_VECTOR(31 downto 0);
        mem_read : in STD_LOGIC;
        mem_write : in STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR(31 downto 0)
    );
    end component;

    signal clk : STD_LOGIC := '0';
    signal addr : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal data_in : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal mem_read : STD_LOGIC := '0';
    signal mem_write : STD_LOGIC := '0';
    signal data_out : STD_LOGIC_VECTOR(31 downto 0);
    signal expected_data_out : STD_LOGIC_VECTOR(31 downto 0);

begin
    uut: DataMemory
        port map (
            clk => clk,
            addr => addr,
            data_in => data_in,
            mem_read => mem_read,
            mem_write => mem_write,
            data_out => data_out
        );

    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    stim_proc: process
    begin
        -- Test Case 1: Write Data
        mem_write <= '1';
        addr <= x"00000010";  -- Example address
        data_in <= x"A5A5A5A5";  -- Example data
        wait for 20 ns;
        mem_write <= '0';

        -- Test Case 2: Read Data
        mem_read <= '1';
        addr <= x"00000010";
        expected_data_out <= x"A5A5A5A5";
        wait for 20 ns;
        assert data_out = expected_data_out
        report "Test Case 2 Failed: Read data does not match written data."
        severity error;
        mem_read <= '0';

        -- Test Case 3: Read from Read-Only Memory
        mem_read <= '1';
        addr <= x"00100000"; -- Read-only memory address
        expected_data_out <= (others => '0'); -- Expected data for read-only memory
        wait for 20 ns;
        assert data_out = expected_data_out
        report "Test Case 3 Failed: Read data does not match expected read-only data."
        severity error;
        mem_read <= '0';

        -- Test Case 4: Write to Read-Only Memory
        mem_write <= '1';
        addr <= x"00100000"; -- Read-only memory address
        data_in <= x"BBBBBBBB"; -- Attempt to write
        wait for 20 ns;
        mem_write <= '0';
        mem_read <= '1';
        wait for 20 ns;
        assert data_out = expected_data_out -- Check if read-only value is unchanged
        report "Test Case 4 Failed: Write to read-only memory succeeded."
        severity error;
        mem_read <= '0';

        -- End the test
        wait;
    end process;

end behavior;
