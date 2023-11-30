library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ALU_tb is
    -- Testbench has no ports
end ALU_tb;

architecture test of ALU_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component ALU
        Port (
            a : in STD_LOGIC_VECTOR (31 downto 0);
            b : in STD_LOGIC_VECTOR (31 downto 0);
            funct3 : in STD_LOGIC_VECTOR (2 downto 0);
            result : inout STD_LOGIC_VECTOR (31 downto 0);
            zero : out STD_LOGIC
        );
    end component;

    -- Signals to connect to UUT
    signal a : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal b : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal funct3 : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal result : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal zero : STD_LOGIC;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: ALU
        port map (
            a => a,
            b => b,
            funct3 => funct3,
            result => result,
            zero => zero
        );

    -- Stimulus process
    stimulus: process
    begin
        -- Test case 1
        a <= std_logic_vector(to_unsigned(15, 32)); -- Example value
        b <= std_logic_vector(to_unsigned(10, 32)); -- Example value
        funct3 <= "000"; -- Add operation
        wait for 100 ns;

        -- Test case 2
        a <= std_logic_vector(to_unsigned(20, 32)); -- Example value
        b <= std_logic_vector(to_unsigned(5, 32)); -- Example value
        funct3 <= "001"; -- Sub operation
        wait for 100 ns;

        -- Add additional test cases as needed

        wait; -- Wait indefinitely, this process will only execute once
    end process stimulus;

end test;
