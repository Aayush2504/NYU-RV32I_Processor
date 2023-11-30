library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
end ALU_tb;

architecture behavior of ALU_tb is 

    -- Component Declaration for the Unit Under Test (UUT)
    component ALU
    port(
        operand_a : in std_logic_vector(31 downto 0);
        operand_b : in std_logic_vector(31 downto 0);
        alu_ctrl : in std_logic_vector(3 downto 0);  -- Adjust based on your ALU control signals
        result : out std_logic_vector(31 downto 0);
        zero : out std_logic
    );
    end component;

    -- Inputs
    signal operand_a : std_logic_vector(31 downto 0) := (others => '0');
    signal operand_b : std_logic_vector(31 downto 0) := (others => '0');
    signal alu_ctrl : std_logic_vector(3 downto 0) := (others => '0');

    -- Outputs
    signal result : std_logic_vector(31 downto 0);
    signal zero : std_logic;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: ALU
        port map (
            operand_a => operand_a,
            operand_b => operand_b,
            alu_ctrl => alu_ctrl,
            result => result,
            zero => zero
        );

    -- Testbench statements
    stim_proc: process
    begin
        -- Test Case 1: Add
        operand_a <= std_logic_vector(to_unsigned(15, 32));
        operand_b <= std_logic_vector(to_unsigned(10, 32));
        alu_ctrl <= "0000";  -- assuming '0000' represents add
        wait for 10 ns;

        -- Test Case 2: Subtract
        operand_a <= std_logic_vector(to_unsigned(20, 32));
        operand_b <= std_logic_vector(to_unsigned(5, 32));
        alu_ctrl <= "0001";  -- assuming '0001' represents subtract
        wait for 10 ns;

        -- Test Case 3: Logical AND
        operand_a <= std_logic_vector(to_unsigned(15, 32));  -- Example operands
        operand_b <= std_logic_vector(to_unsigned(7, 32));
        alu_ctrl <= "0010";  -- Control code for AND
        wait for 10 ns;

        -- Test Case 4: Logical OR
        operand_a <= std_logic_vector(to_unsigned(12, 32));
        operand_b <= std_logic_vector(to_unsigned(5, 32));
        alu_ctrl <= "0011";  -- Control code for OR
        wait for 10 ns;

        -- Test Case 5: Logical XOR
        operand_a <= std_logic_vector(to_unsigned(10, 32));
        operand_b <= std_logic_vector(to_unsigned(6, 32));
        alu_ctrl <= "0100";  -- Control code for XOR
        wait for 10 ns;

        -- Test Case 6: Shift Left Logical
        operand_a <= std_logic_vector(to_unsigned(4, 32));
        operand_b <= std_logic_vector(to_unsigned(2, 32));  -- Shift by 2 bits
        alu_ctrl <= "0101";  -- Control code for SLL
        wait for 10 ns;

        -- Test Case 7: Shift Right Logical
        operand_a <= std_logic_vector(to_unsigned(16, 32));
        operand_b <= std_logic_vector(to_unsigned(2, 32));  -- Shift by 2 bits
        alu_ctrl <= "0110";  -- Control code for SRL
        wait for 10 ns;

        -- Test Case 8: Arithmetic Shift Right
        operand_a <= std_logic_vector(to_unsigned(128, 32));
        operand_b <= std_logic_vector(to_unsigned(1, 32));  -- Shift by 1 bit
        alu_ctrl <= "0111";  -- Control code for SRA
        wait for 10 ns;

        -- Test Case 9: Greater Than Comparison (Subtract and Check Zero Flag)
        operand_a <= std_logic_vector(to_unsigned(20, 32));
        operand_b <= std_logic_vector(to_unsigned(10, 32));
        alu_ctrl <= "1000";  -- Custom Control code for GT comparison
        wait for 10 ns;

        -- Test Case 10: Equality Check (Subtract and Check Zero Flag)
        operand_a <= std_logic_vector(to_unsigned(15, 32));
        operand_b <= std_logic_vector(to_unsigned(15, 32));
        alu_ctrl <= "1001";  -- Custom Control code for EQ comparison
        wait for 10 ns;
          
        -- End the test
    end process;

end behavior;
