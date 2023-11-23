library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory is
    Port ( clk : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR (31 downto 0);
           write_data : in STD_LOGIC_VECTOR (31 downto 0);
           write_enable : in STD_LOGIC_VECTOR (3 downto 0); -- Enable for each byte
           mem_read : in STD_LOGIC;
           mem_write : in STD_LOGIC;
           read_data : out STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is
    type mem_type is array (0 to 1023) of std_logic_vector(31 downto 0); -- 4KBytes as 1024 x 32-bit words
    signal ram : mem_type := (others => (others => '0')); -- Initialized to zero

    -- Function to handle byte-level write
    function write_byte(data : std_logic_vector(31 downto 0); byte_data : std_logic_vector(7 downto 0); byte_sel : integer) return std_logic_vector is
    begin
        return data(31 downto (byte_sel+1)*8) & byte_data & data((byte_sel*8)-1 downto 0);
    end function;

begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- Write operation
            if mem_write = '1' and address >= x"80000000" then
                for i in 0 to 3 loop
                    if write_enable(i) = '1' then
                        ram(to_integer(unsigned(address(31 downto 2))))(i*8+7 downto i*8) <= write_data(i*8+7 downto i*8);
                    end if;
                end loop;
            end if;
        end if;
    end process;

    -- Read operation
    read_data <= ram(to_integer(unsigned(address(31 downto 2))));
end Behavioral;
