library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory is
    Port ( 
        clk : in STD_LOGIC;
        addr : in STD_LOGIC_VECTOR (31 downto 0);
        data_in : in STD_LOGIC_VECTOR (31 downto 0);
        mem_read : in STD_LOGIC;
        mem_write : in STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR (31 downto 0)
    );
end DataMemory;

architecture Behavioral of DataMemory is
    type RAM_TYPE is array (0 to 4095) of STD_LOGIC_VECTOR (31 downto 0); -- 4KB RAM
    signal RAM : RAM_TYPE;

    -- Constants for special read-only memory-mapped values
    constant GROUP_MEMBER_COUNT_1 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0'); -- Update with actual values
    constant GROUP_MEMBER_COUNT_2 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0'); -- Update with actual values
    constant GROUP_MEMBER_COUNT_3 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0'); -- Update with actual values

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if mem_write = '1' then
                -- Write operation, except for read-only addresses
                case addr is
                    when x"00100000" => null; -- Do nothing (read-only)
                    when x"00100004" => null; -- Do nothing (read-only)
                    when x"00100008" => null; -- Do nothing (read-only)
                    when others => RAM(conv_integer(addr)) <= data_in;
                end case;
            end if;
            if mem_read = '1' then
                -- Read operation
                case addr is
                    when x"00100000" => data_out <= GROUP_MEMBER_COUNT_1;
                    when x"00100004" => data_out <= GROUP_MEMBER_COUNT_2;
                    when x"00100008" => data_out <= GROUP_MEMBER_COUNT_3;
                    when others => data_out <= RAM(conv_integer(addr));
                end case;
            end if;
        end if;
    end process;
end Behavioral;
