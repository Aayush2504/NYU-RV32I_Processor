LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY RegFile_tb IS
END RegFile_tb;

ARCHITECTURE behavior OF RegFile_tb IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT RegFile
    PORT(
        clk : IN  std_logic;
        reset : IN  std_logic;
        reg_write_en : IN  std_logic;
        reg_write_dest : IN  std_logic_vector(4 downto 0);
        reg_write_data : IN  std_logic_vector(31 downto 0);
        reg_read_addr_1 : IN  std_logic_vector(4 downto 0);
        reg_read_data_1 : OUT  std_logic_vector(31 downto 0);
        reg_read_addr_2 : IN  std_logic_vector(4 downto 0);
        reg_read_data_2 : OUT  std_logic_vector(31 downto 0)
      );
    END COMPONENT;
   
    --Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal reg_write_en : std_logic := '0';
    signal reg_write_dest : std_logic_vector(4 downto 0) := (others => '0');
    signal reg_write_data : std_logic_vector(31 downto 0) := (others => '0');
    signal reg_read_addr_1 : std_logic_vector(4 downto 0) := (others => '0');
    signal reg_read_addr_2 : std_logic_vector(4 downto 0) := (others => '0');

    --Outputs
    signal reg_read_data_1 : std_logic_vector(31 downto 0);
    signal reg_read_data_2 : std_logic_vector(31 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: RegFile PORT MAP (
        clk => clk,
        reset => reset,
        reg_write_en => reg_write_en,
        reg_write_dest => reg_write_dest,
        reg_write_data => reg_write_data,
        reg_read_addr_1 => reg_read_addr_1,
        reg_read_data_1 => reg_read_data_1,
        reg_read_addr_2 => reg_read_addr_2,
        reg_read_data_2 => reg_read_data_2
    );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin       
        -- hold reset state for 100 ns.
        wait for 100 ns;    
        reset <= '1';
        wait for 100 ns;
        reset <= '0';      

        -- Write to a register
        reg_write_en <= '1';
        reg_write_dest <= "00001";
        reg_write_data <= x"12345678";
        wait for clk_period*10;

        -- Read from the register
        reg_read_addr_1 <= "00001";
        wait for clk_period*10;

        -- Write to another register
        reg_write_dest <= "00010";
        reg_write_data <= x"9ABCDEF0";
        wait for clk_period*10;

        -- Read from the second register
        reg_read_addr_2 <= "00010";
        wait for clk_period*10;

        -- End simulation
        wait;
    end process;

END;
