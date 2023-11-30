library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ALU_tb is
-- Testbench entity does not have ports
end ALU_tb;

architecture behavior of ALU_tb is 

    -- Component Declaration for the Unit Under Test (UUT)
    component ALU
    port(
        a : in STD_LOGIC_VECTOR(31 downto 0);
        b : in STD_LOGIC_VECTOR(31 downto 0);
        funct3 : in STD_LOGIC_VECTOR(2 downto 0);
        result : inout STD_LOGIC_VECTOR(31 downto 0);
        zero : out STD_LOGIC
    );
    end component;

    -- Inputs
    signal a : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal b : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal funct3 : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');

    -- Outputs
    signal result : STD_LOGIC_VECTOR(31 downto 0);
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

    -- Testbench statements
    stim_proc: process
    begin
        -- Test Case 1: Add
        a <= std_logic_vector(to_signed(10, 32));
        b <= std_logic_vector(to_signed(15, 32));
        funct3 <= "000";
        wait for 10 ns;

        -- Test Case 2: Subtract
        a <= std_logic_vector(to_signed(20, 32));
        b <= std_logic_vector(to_signed(5, 32));
        funct3 <= "001";
        wait for 10 ns;

        -- Test Case 3: AND
        a <= std_logic_vector(to_signed(12, 32));
        b <= std_logic_vector(to_signed(9, 32));
        funct3 <= "010";
        wait for 10 ns;

        -- Test Case 4: OR
        a <= std_logic_vector(to_signed(5, 32));
        b <= std_logic_vector(to_signed(10, 32));
        funct3 <= "011";
        wait for 10 ns;

        -- Test Case 5: XOR
        a <= std_logic_vector(to_signed(15, 32));
        b <= std_logic_vector(to_signed(6, 32));
        funct3 <= "100";
        wait for 10 ns;

        -- Test Case 6: Shift Left Logical (SLL)
        a <= std_logic_vector(to_signed(3, 32));
        b <= std_logic_vector(to_signed(2, 32));  -- Shift by 2
        funct3 <= "101";
        wait for 10 ns;

        -- Test Case 7: Shift Right Logical (SRL)
        a <= std_logic_vector(to_signed(8, 32));
        b <= std_logic_vector(to_signed(1, 32));  -- Shift by 1
        funct3 <= "110";
        wait for 10 ns;

        -- Test Case 8: Additional test for ADD
        a <= std_logic_vector(to_signed(25, 32));
        b <= std_logic_vector(to_signed(17, 32));
        funct3 <= "000";
        wait for 10 ns;

        -- Test Case 9: Additional test for SUB
        a <= std_logic_vector(to_signed(50, 32));
        b <= std_logic_vector(to_signed(20, 32));
        funct3 <= "001";
        wait for 10 ns;

        -- Test Case 10: Additional test for AND
        a <= std_logic_vector(to_signed(14, 32));
        b <= std_logic_vector(to_signed(5, 32));
        funct3 <= "010";
        wait for 10 ns;

        wait;
    end process;

end behavior;
