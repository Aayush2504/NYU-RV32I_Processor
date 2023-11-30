library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegFile is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        -- write port 
        reg_write_en : in STD_LOGIC;
        reg_write_dest : in STD_LOGIC_VECTOR(4 downto 0);
        reg_write_data : in STD_LOGIC_VECTOR(31 downto 0);
        -- read port 1
        reg_read_addr_1 : in STD_LOGIC_VECTOR(4 downto 0);
        reg_read_data_1 : out STD_LOGIC_VECTOR(31 downto 0);
        -- read port 2
        reg_read_addr_2 : in STD_LOGIC_VECTOR(4 downto 0);
        reg_read_data_2 : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RegFile;

architecture Behavioral of RegFile is
        type reg_array_type is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
        signal reg_array : reg_array_type := (others => (others => '0'));
begin
    -- write operation
    process(clk, reset)
    begin
        if reset = '1' then
            for i in 0 to 15 loop
                reg_array(i) <= (others => '0');
            end loop;
        elsif rising_edge(clk) then
            if reg_write_en = '1' then
                reg_array(conv_integer(unsigned(reg_write_dest))) <= reg_write_data;
            end if;
        end if;
    end process;

    -- read operations
    reg_read_data_1 <= reg_array(conv_integer(unsigned(reg_read_addr_1)));
    reg_read_data_2 <= reg_array(conv_integer(unsigned(reg_read_addr_2)));

end Behavioral;
