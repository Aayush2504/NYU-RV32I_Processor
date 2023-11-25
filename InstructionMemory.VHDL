library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
    Port (
        clk : in std_logic;
        addr : in std_logic_vector(31 downto 0);
        instr : out std_logic_vector(31 downto 0)
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is

    -- Define the size of the instruction memory
    constant INSTR_MEM_SIZE : integer := 512;
    type instr_mem_type is array (0 to INSTR_MEM_SIZE - 1) of std_logic_vector(31 downto 0);

    -- Initialize the instruction memory with predefined instructions
    signal instr_mem : instr_mem_type := (
        0 => "00000000010000001000000010110111", -- LUI x1, 0x00004
        1 => "00000000010100010000000100010111", -- AUIPC x2, 0x00005
        2 => "00000000000000010011000011101111", -- JAL x3, 8
        3 => "00000000010000101000010011100111", -- JALR x4, x5, 4
        4 => "00000000000000111000011011100011", -- BEQ x6, x7, 12
        5 => "00000000000001001000010000000011", -- LW x8, 0(x9)
        6 => "00000000010001010001010100100011", -- SW x10, 4(x11)
        7 => "00000000000101101100011010010011", -- ADDI x12, x13, 1
        8 => "00000000110001111011111100110011", -- ADD x14, x15, x16
        9 => "01000000110110001101100010110011", -- SUB x17, x18, x19
        others => (others => '0')
    );

begin

    process(clk)
    begin
        if rising_edge(clk) then
            -- Convert byte address to word address and retrieve the instruction
            instr <= instr_mem(to_integer(unsigned(addr(31 downto 2))));
        end if;
    end process;

end Behavioral;

