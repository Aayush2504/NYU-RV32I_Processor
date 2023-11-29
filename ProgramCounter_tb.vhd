library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ProgramCounter_tb is
end ProgramCounter_tb;

architecture Behavioral of ProgramCounter_tb is
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal pc_out : STD_LOGIC_VECTOR(31 downto 0);

    component ProgramCounter
        Port ( 
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            pc_out : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Instantiate the ProgramCounter module
    signal uut: ProgramCounter;

begin
    uut_inst: ProgramCounter port map (clk, reset, pc_out);

    -- Clock process
    process
    begin
        while now < 1000 ns loop
            clk <= not clk;
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimulus process
    process
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 100 ns;  -- Simulate for some clock cycles
        assert pc_out = "00000004" report "Error: PC not initialized correctly" severity error;

        -- Additional test cases can be added here

        wait;
    end process;

end Behavioral;

