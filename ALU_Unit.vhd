library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;  -- Using numeric_std for arithmetic operations

entity ALU is
    Port (
        a : in STD_LOGIC_VECTOR (31 downto 0);  -- First operand
        b : in STD_LOGIC_VECTOR (31 downto 0);  -- Second operand
        funct3 : in STD_LOGIC_VECTOR (2 downto 0);  -- ALU control signals
        result : inout STD_LOGIC_VECTOR (31 downto 0);  -- ALU result
        zero : out STD_LOGIC  -- Zero flag
    );
end ALU;

architecture Behavioral of ALU is
begin
    process(a, b, funct3)
    variable a_int, b_int : INTEGER;  -- Variables for integer values of a and b
    begin
        -- Convert b to integer for shift operations
        b_int := to_integer(unsigned(b(4 downto 0)));  -- Assuming 5 bits are enough for shift amount

        case funct3 is
            when "000" =>  -- add
                result <= std_logic_vector(signed(a) + signed(b));
            when "001" =>  -- sub
                result <= std_logic_vector(signed(a) - signed(b));
            when "010" =>  -- and 
                result <= a and b;
            when "011" =>  -- or
                result <= a or b;
            when "100" =>  -- xor
                result <= a xor b;
            when "101" =>  -- sll
                result <= std_logic_vector(shift_left(signed(a), b_int));
            when "110" =>  -- srl
                result <= std_logic_vector(shift_right(signed(a), b_int));
            when others => 
                result <= (others => '0');
        end case;
        
        -- Set zero flag
      if unsigned(result) = 0 then
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;

end Behavioral;
