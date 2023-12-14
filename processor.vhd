-- Program Counter (PC) component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pc_out : out STD_LOGIC_VECTOR(31 downto 0));
end PC;

architecture Behavioral of PC is
    signal pc_reg : STD_LOGIC_VECTOR(31 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            pc_reg <= (others => '0');
        elsif rising_edge(clk) then
            pc_reg <= pc_reg + 4; -- Assuming 32-bit instructions
        end if;
    end process;

    pc_out <= pc_reg;
end Behavioral;


-- Control Unit component
-- Assuming a simple control unit with opcode decoding

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CU is
    Port ( opcode : in STD_LOGIC_VECTOR(6 downto 0);
           control_signals : out STD_LOGIC_VECTOR(7 downto 0));
end CU;

architecture Behavioral of CU is
begin
    process(opcode)
    begin
        case opcode is
            when "0000000" => control_signals <= "00000001"; -- R-type instruction
            when "1100011" => control_signals <= "00000100"; -- Branch instruction
            when others => control_signals <= (others => '0'); -- Default
        end case;
    end process;
end Behavioral;


-- Register File component
-- Assuming a simple register file with synchronous read and write

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RF is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           rs1, rs2, rd : in STD_LOGIC_VECTOR(4 downto 0);
           data_in : in STD_LOGIC_VECTOR(31 downto 0);
           data_out1, data_out2 : out STD_LOGIC_VECTOR(31 downto 0));
end RF;

architecture Behavioral of RF is
    type reg_array is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
    signal registers : reg_array := (others => (others => '0'));
begin
    process(clk, rst)
    begin
        if rst = '1' then
            registers <= (others => (others => '0'));
        elsif rising_edge(clk) then
            data_out1 <= registers(conv_integer(rs1));
            data_out2 <= registers(conv_integer(rs2));
            if rd /= "00000" then
                registers(conv_integer(rd)) <= data_in;
            end if;
        end if;
    end process;
end Behavioral;


-- ALU component
-- Assuming a simple ALU with basic operations

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_1 is
    Port ( operation : in STD_LOGIC_VECTOR(2 downto 0);
           operand1, operand2 : in STD_LOGIC_VECTOR(31 downto 0);
           result : out STD_LOGIC_VECTOR(31 downto 0));
end ALU_1;

architecture Behavioral of ALU_1 is
begin
    process(operation, operand1, operand2)
    begin
        case operation is
            when "000" => result <= operand1 + operand2; -- ADD
            when "001" => result <= operand1 - operand2; -- SUB
            when "010" => result <= operand1 AND operand2; -- AND
            when "011" => result <= operand1 OR operand2; -- OR
            when "100" => result <= operand1 XOR operand2; -- XOR
            when others => result <= (others => '0');
        end case;
    end process;
end Behavioral;


-- Instruction/Data Memory component
-- Assuming a simple dual-ported memory

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memory is
    Port ( clk : in STD_LOGIC;
           mem_write, mem_read : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR(31 downto 0);
           data_in : in STD_LOGIC_VECTOR(31 downto 0);
           data_out : out STD_LOGIC_VECTOR(31 downto 0));
end Memory;

architecture Behavioral of Memory is
    type mem_array is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
    signal memory : mem_array := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if mem_write = '1' then
                memory(conv_integer(address)) <= data_in;
            end if;
            if mem_read = '1' then
                data_out <= memory(conv_integer(address));
            end if;
        end if;
    end process;
end Behavioral;


-- Main Processor component

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Processor is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           opcode : in STD_LOGIC_VECTOR(6 downto 0);
           rs1, rs2, rd : in STD_LOGIC_VECTOR(4 downto 0);
           mem_write, mem_read : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR(31 downto 0);
           data_out1, data_out2 : inout STD_LOGIC_VECTOR(31 downto 0));
end Processor;

architecture Behavioral of Processor is
    signal pc_out : STD_LOGIC_VECTOR(31 downto 0);
    signal control_signals : STD_LOGIC_VECTOR(7 downto 0);
    signal alu_result : STD_LOGIC_VECTOR(31 downto 0);
    signal mem_data_out : STD_LOGIC_VECTOR(31 downto 0);
begin
    PC_unit: entity work.ProgramCounter  -- Portmap Instantiation of Program Counter
        port map (clk => clk, rst => rst, pc_out => pc_out);

    Control_unit: entity work.CU         --Portmap Instantiation of Control Unit
        port map (opcode => opcode, control_signals => control_signals);

    Register_file: entity work.RF        --Portmap Instantiation of Register File
        port map (clk => clk, rst => rst, rs1 => rs1, rs2 => rs2, rd => rd,
                  data_in => data_in, data_out1 => data_out1, data_out2 => data_out2);
      
          ALU_unit: entity work.ALU_1     -- Portmap Initiation of ALU 
        port map (operation => control_signals(2 downto 0),
                  operand1 => data_out1,
                  operand2 => data_out2,
                  result => alu_result);

    Memory_unit: entity work.Memory     -- Portmap initiation of Memory
        port map (clk => clk,
                  mem_write => mem_write,
                  mem_read => mem_read,
                  address => alu_result, -- Using ALU result as the memory address
                  data_in => data_in,
                  data_out => mem_data_out);

end Behavioral;


