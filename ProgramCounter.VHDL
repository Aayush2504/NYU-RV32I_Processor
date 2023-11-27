library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProgramCounter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           pc_out : out STD_LOGIC_VECTOR(31 downto 0));
end ProgramCounter;

architecture Behavioral of ProgramCounter is
    signal pc_reg : STD_LOGIC_VECTOR(31 downto 0) := "01000000000000000000000000000000";  -- Start address of instruction memory
begin
    process(clk, reset)
    begin
        if reset = '1' then
            pc_reg <= "01000000000000000000000000000000";  -- Reset PC to the start address
        elsif rising_edge(clk) then
            -- Increment PC by 4 (assuming a word-addressable memory)
            pc_reg <= pc_reg + std_logic_vector(to_unsigned(4, pc_reg'length));
        end if;
    end process;

    -- Output the current value of the PC
    pc_out <= pc_reg;
end Behavioral;
