library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM is
    Port ( address : in STD_LOGIC_VECTOR (5 downto 0); -- 6-bit address
           instruction : out STD_LOGIC_VECTOR (31 downto 0)); -- 32-bit instruction
end ROM;

architecture Behavioral of ROM is
    type rom_type is array (0 to 63) of std_logic_vector(31 downto 0); -- 64 instructions
    signal rom_memory : rom_type := (others => (others => '0'));

begin
    -- Fetch instruction
    instruction <= rom_memory(to_integer(unsigned(address)));
end Behavioral;
