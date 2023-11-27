library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile is
    Port (
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        regWriteEn: in STD_LOGIC; -- Enable signal for writing to a register
        readReg1: in STD_LOGIC_VECTOR(4 downto 0); -- Address for first register to read
        readReg2: in STD_LOGIC_VECTOR(4 downto 0); -- Address for second register to read
        writeReg: in STD_LOGIC_VECTOR(4 downto 0); -- Address for register to write
        writeData: in STD_LOGIC_VECTOR(31 downto 0); -- Data to write to the register
        readData1: out STD_LOGIC_VECTOR(31 downto 0); -- Output of first read register
        readData2: out STD_LOGIC_VECTOR(31 downto 0) -- Output of second read register
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    type reg_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal registers: reg_array := (others => (others => '0')); -- Initialize all registers to 0

begin
    process (clk, rst)
    begin
        if rst = '1' then
            -- Reset logic: Set all registers to 0
            registers <= (others => (others => '0'));
        elsif rising_edge(clk) then
            -- Write logic
            if regWriteEn = '1' then
                -- Write data to the selected register, R0 is always 0
                if writeReg /= "00000" then
                    registers(to_integer(unsigned(writeReg))) <= writeData;
                end if;
            end if;
        end if;
    end process;

    -- Read logic (Asynchronous)
    readData1 <= registers(to_integer(unsigned(readReg1)));
    readData2 <= registers(to_integer(unsigned(readReg2)));

end Behavioral;
