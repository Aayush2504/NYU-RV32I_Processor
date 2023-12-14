library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity processor is
    Port (
        clk : in std_logic;
        reset : in std_logic
    );
end processor;

architecture Behavioral of processor is

    -- Signals for inter-module communication
    signal pc, next_pc, alu_result : std_logic_vector(31 downto 0);
    signal instruction : std_logic_vector(31 downto 0);
    signal reg_data1, reg_data2, write_data : std_logic_vector(31 downto 0);
    signal write_enable : std_logic;
    signal reg_addr1, reg_addr2, write_addr : std_logic_vector(4 downto 0);
    signal branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write : std_logic;
    signal alu_op : std_logic_vector(1 downto 0);

    -- Component instantiation
    component RegisterFile
        Port (
            clk : in std_logic;
            reg_addr1 : in std_logic_vector(4 downto 0);
            reg_addr2 : in std_logic_vector(4 downto 0);
            write_addr : in std_logic_vector(4 downto 0);
            write_data : in std_logic_vector(31 downto 0);
            write_enable : in std_logic;
            reg_data1 : out std_logic_vector(31 downto 0);
            reg_data2 : out std_logic_vector(31 downto 0)
        );
    end component;

    component ProgramCounter
        Port (
            clk : in std_logic;
            reset : in std_logic;
            next_pc : in std_logic_vector(31 downto 0);
            pc_out : out std_logic_vector(31 downto 0)
        );
    end component;

    component InstructionMemory
        Port (
            address : in std_logic_vector(31 downto 0);
            instruction : out std_logic_vector(31 downto 0)
        );
    end component;

    component DataMemory
        Port (
            clk : in std_logic;
            mem_addr : in std_logic_vector(31 downto 0);
            write_data : in std_logic_vector(31 downto 0);
            mem_write : in std_logic;
            mem_read : in std_logic;
            read_data : out std_logic_vector(31 downto 0)
        );
    end component;

    component ControlUnit
        Port (
            opcode : in std_logic_vector(6 downto 0);
            branch : out std_logic;
            mem_read : out std_logic;
            mem_to_reg : out std_logic;
            alu_op : out std_logic_vector(1 downto 0);
            mem_write : out std_logic;
            alu_src : out std_logic;
            reg_write : out std_logic
        );
    end component;

    component ALU
        Port (
            alu_src1 : in std_logic_vector(31 downto 0);
            alu_src2 : in std_logic_vector(31 downto 0);
            alu_op : in std_logic_vector(1 downto 0);
            zero : out std_logic;
            alu_result : out std_logic_vector(31 downto 0)
        );
    end component;

begin

    -- Instantiate the ProgramCounter
    pc_inst: ProgramCounter port map (
        clk => clk,
        reset => reset,
        next_pc => next_pc,
        pc_out => pc
    );

    -- Instantiate the InstructionMemory
    inst_mem_inst: InstructionMemory port map (
        address => pc,
        instruction => instruction
    );

    -- Instantiate the RegisterFile
    reg_file_inst: RegisterFile port map (
        clk => clk,
        reg_addr1 => instruction(19 downto 15),
        reg_addr2 => instruction(24 downto 20),
        write_addr => instruction(11 downto 7),
        write_data => write_data,
        write_enable => reg_write,
        reg_data1 => reg_data1,
        reg_data2 => reg_data2
    );

    -- Instantiate the ALU
    alu_inst: ALU port map (
        alu_src1 => reg_data1,
        alu_src2 => (others => '0') when alu_src = '1' else reg_data2,
        alu_op => alu_op,
        zero => open,
        alu_result => alu_result
    );

    -- Instantiate the DataMemory
    data_mem_inst: DataMemory port map (
        clk => clk,
        mem_addr => alu_result,
        write_data => reg_data2,
        mem_write => mem_write,
        mem_read => mem_read,
        read_data => open
    );

    -- Instantiate the ControlUnit
    control_unit_inst: ControlUnit port map (
        opcode => instruction(6 downto 0),
        branch => branch,
        mem_read => mem_read,
        mem_to_reg => mem_to_reg,
        alu_op => alu_op,
        mem_write => mem_write,
        alu_src => alu_src,
        reg_write => reg_write
    );

-- Processor Logic
process(clk)
    variable operand_a, operand_b : std_logic_vector(31 downto 0);
begin
    if rising_edge(clk) then
        if reset = '1' then
            pc <= x"01000000"; -- Reset PC to start address
        else
            -- Fetch instruction
            instruction <= instruction_memory(pc);

            -- Decode instruction
            control_unit_inst(opcode => instruction(6 downto 0),
                              branch => branch,
                              mem_read => mem_read,
                              mem_to_reg => mem_to_reg,
                              alu_op => alu_op,
                              mem_write => mem_write,
                              alu_src => alu_src,
                              reg_write => reg_write);

            -- Set operands for ALU
            operand_a := reg_file_inst(reg_addr1 => instruction(19 downto 15));
            operand_b := (others => '0') when alu_src = '1' else reg_file_inst(reg_addr2 => instruction(24 downto 20));

            -- ALU operation
            alu_inst(alu_src1 => operand_a,
                     alu_src2 => operand_b,
                     alu_op => alu_op,
                     alu_result => alu_result);

            -- Data Memory Access
            if mem_read = '1' then
                read_data <= data_mem_inst(mem_addr => alu_result,
                                           mem_read => mem_read);
            end if;

            if mem_write = '1' then
                data_mem_inst(mem_addr => alu_result,
                              write_data => operand_b,
                              mem_write => mem_write);
            end if;

            -- Update Register File
            if reg_write = '1' then
                reg_file_inst(write_addr => instruction(11 downto 7),
                              write_data => alu_result,
                              write_enable => reg_write);
            end if;

            -- Calculate next PC value
            next_pc <= pc + 4; -- Simple sequential increment for next instruction
            pc <= next_pc;
        end if;
    end if;
end process;

end Behavioral;
