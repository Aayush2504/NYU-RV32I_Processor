library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile_tb is
end RegisterFile_tb;

architecture behavior of RegisterFile_tb is 
    -- Component Declaration for the Unit Under Test (UUT)
    component RegisterFile
    port(
        clk : in std_logic;
        reset : in std_logic;
        reg_write_en : in std_logic;
        write_reg : in std_logic_vector(4 downto 0);
        read_reg1 : in std_logic_vector(4 downto 0);
        read_reg2 : in std_logic_vector(4 downto 0);
        write_data : in std_logic_vector(31 downto 0);
        read_data1 : out std_logic_vector(31 downto 0);
        read_data2 : out std_logic_vector(31 downto 0)
    );
    end component;

    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal reg_write_en : std_logic := '0';
    signal write_reg : std_logic_vector(4 downto 0) := (others => '0');
    signal read_reg1 : std_logic_vector(4 downto 0) := (others => '0');
    signal read_reg2 : std_logic_vector(4 downto 0) := (others => '0');
    signal write_data : std_logic_vector(31 downto 0) := (others => '0');

    -- Outputs
    signal read_data1 : std_logic_vector(31 downto 0);
    signal read_data2 : std_logic_vector(31 downto 0);

    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns; -- Clock period is 20 ns
        clk <= '1';
        wait for 10 ns;
    end process;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: RegisterFile
        port map (
            clk => clk,
            reset => reset,
            reg_write_en => reg_write_en,
            write_reg => write_reg,
            read_reg1 => read_reg1,
            read_reg2 => read_reg2,
            write_data => write_data,
            read_data1 => read_data1,
            read_data2 => read_data2
        );

    -- Testbench statements
    stim_proc: process
    begin
        -- Test Case 1: Write and Read Different Registers
        reg_write_en <= '1';
        write_reg <= "00001";
        write_data <= x"000000A5";
        wait for 20 ns;

        reg_write_en <= '0';
        read_reg1 <= "00001";
        wait for 20 ns;

        -- Test Case 2: Check Reset Behavior
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 20 ns;

        -- Test Case 3: Simultaneous Read from Two Registers
        reg_write_en <= '1';
        write_reg <= "00010";
        write_data <= x"00000A5A";
        wait for 20 ns;

        reg_write_en <= '0';
        read_reg1 <= "00001";
        read_reg2 <= "00010";
        wait for 20 ns;

        -- Test Case 4: Write Enable Control
        -- Write to a register with write enable disabled
        reg_write_en <= '0';
        write_reg <= "00100"; 
        write_data <= x"00000A5A";
        wait for 20 ns;

        -- Enable write and write again
        reg_write_en <= '1';
        wait for 20 ns;

        -- Test Case 5: Read-After-Write Consistency
        -- Write to a register
        write_reg <= "00110"; 
        write_data <= x"0000A5A5"; 
        wait for 20 ns;

        -- Read from the same register
        reg_write_en <= '0';
        read_reg1 <= "00110"; 
        wait for 20 ns;

        -- Test Case 6: Read Unwritten Register
        -- Read from an unwritten register
        read_reg1 <= "01010"; 
        wait for 20 ns;

        -- Test Case 7: Boundary Register Addresses
        -- Write and read the last register
        write_reg <= "11111"; 
        write_data <= x"000FFFFF"; 
        reg_write_en <= '1';
        wait for 20 ns;

        -- Read from the last register
        reg_write_en <= '0';
        read_reg1 <= "11111"; 
        wait for 20 ns;

        -- Test Case 8: Write and Read from Register 0
        -- Attempt to write to register 0
        write_reg <= "00000"; 
        write_data <= x"00000A5A"; 
        reg_write_en <= '1';
        wait for 20 ns;

        -- Read from register 0
        reg_write_en <= '0';
        read_reg1 <= "00000"; 
        wait for 20 ns;

        -- Test Case 9: Multiple Consecutive Writes
        -- Perform multiple writes
        write_reg <= "01000"; 
        write_data <= x"00000A5A"; 
        reg_write_en <= '1';
        wait for 20 ns;
        write_data <= x"00005A5A"; 
        wait for 20 ns;

        -- Read the last value
        reg_write_en <= '0';
        read_reg1 <= "01000"; 
        wait for 20 ns;

        -- End the test
        wait;
    end process;
end behavior;

