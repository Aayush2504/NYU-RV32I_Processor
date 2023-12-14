LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY Processor_TB IS
END Processor_TB;

ARCHITECTURE behavior OF Processor_TB IS 

    SIGNAL clk, rst, mem_write, mem_read : STD_LOGIC := '0';
    SIGNAL data_in, data_out1, data_out2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL opcode: STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL rs1,rs2,rd: STD_LOGIC_VECTOR(4 downto 0);

BEGIN
    -- Instantiate the processor
    Processor_inst : ENTITY work.Processor
        PORT MAP (
            clk => clk,
            rst => rst,
            opcode => opcode,
            rs1 => rs1,
            rs2 => rs2,
            rd => rd,
            mem_write => mem_write,
            mem_read => mem_read,
            data_in => data_in,
            data_out1 => data_out1,
            data_out2 => data_out2
        );

    -- Clock process
    clk_process: PROCESS
    BEGIN
        WAIT FOR 5 NS;
        clk <= NOT clk;
    END PROCESS;

    -- Stimulus process
    stim_process: PROCESS
    BEGIN
        -- Initialize inputs
        rst <= '1';
        WAIT FOR 10 NS;
        rst <= '0';

        WAIT FOR 10 NS;
        opcode <= "0000000"; -- R-type instruction
        rs1 <= "00001";
        rs2 <= "00010";
        rd <= "00100";
        mem_write <= '0';
        mem_read <= '0';
        data_in <= (others => '0');

        WAIT FOR 10 NS;

        -- Add more test cases as needed

        WAIT;

    -- Test Case 1: R-Type Instruction (Addition)
		WAIT FOR 10 NS;
		opcode <= "0000000"; -- R-type instruction
		rs1 <= "00001";
		rs2 <= "00010";
		rd <= "00100";
		mem_write <= '0';
		mem_read <= '0';
		data_in <= (others => '0');

    -- Test Case 2: Memory Read
		WAIT FOR 10 NS;
		opcode <= "0000011"; -- Load instruction
		rs1 <= "00001";
		rs2 <= "00000";
		rd <= "00100";
		mem_write <= '0';
		mem_read <= '1';
		data_in <= (others => '0');

    -- Test Case 3: Branch Instruction
		WAIT FOR 10 NS;
		opcode <= "1100011"; -- Branch instruction
		rs1 <= "00001";
		rs2 <= "00010";
		rd <= "00100";
		mem_write <= '0';
		mem_read <= '0';
		data_in <= (others => '0');

    --  -- Test Case 4: R-Type Instruction (Subtraction)
		WAIT FOR 10 NS;
		opcode <= "0000000"; -- R-type instruction
		rs1 <= "00001";
		rs2 <= "00010";
		rd <= "00101"; -- Use a different destination register
		mem_write <= '0';
		mem_read <= '0';
		data_in <= (others => '0');

    -- Test Case 5: Memory Write
		WAIT FOR 10 NS;
		opcode <= "0100011"; -- Store instruction
		rs1 <= "00001"; 
		rs2 <= "00000"; -- Immediate value for offset
		rd <= "00101"; -- Source register for the data to be stored
		mem_write <= '1';
		mem_read <= '0';
		data_in <= "11110000111100001111000011110000"; -- Example data to be stored

    -- Test Case 6: Conditional Branch (if rs1 == rs2)
		WAIT FOR 10 NS;
		opcode <= "1100011"; -- Branch instruction
		rs1 <= "00001";
		rs2 <= "00001"; -- Equal to rs1
		rd <= "00110"; -- Destination register for the branch result
		mem_write <= '0';
		mem_read <= '0';
		data_in <= (others => '0');
     -- Test Case 7: R-Type Instruction (Logical AND)
		WAIT FOR 10 NS;
		opcode <= "0000000"; -- R-type instruction
		rs1 <= "00001";
		rs2 <= "00010";
		rd <= "00110"; -- Use a different destination register
		mem_write <= '0';
		mem_read <= '0';
		data_in <= (others => '0');

    -- Test Case 8: Memory Read (Negative Offset)
		WAIT FOR 10 NS;
		opcode <= "0000011"; -- Load instruction
		rs1 <= "00001";
		rs2 <= "00000";
		rd <= "00111"; -- Use a different destination register
		mem_write <= '0';
		mem_read <= '1';
		data_in <= (others => '0');

    -- Test Case 9: Conditional Branch (if rs1 != rs2)
		WAIT FOR 10 NS;
		opcode <= "1100011"; -- Branch instruction
		rs1 <= "00001";
		rs2 <= "00010"; -- Not equal to rs1
		rd <= "01000"; -- Use a different destination register
		mem_write <= '0';
		mem_read <= '0';
		data_in <= (others => '0');

    -- Test Case 10: Memory Write (Immediate Offset)
		WAIT FOR 10 NS;
		opcode <= "0100011"; -- Store instruction
		rs1 <= "00001";
		rs2 <= "00001"; -- Equal to rs1
		rd <= "01001"; -- Use a different source register
		mem_write <= '1';
		mem_read <= '0';
		data_in <= "00001111000011110000111100001111"; -- Example data to be stored

    -- Test Case 11: Conditional Branch (if rs1 < rs2)
		WAIT FOR 10 NS;
		opcode <= "1100011"; -- Branch instruction
		rs1 <= "11111"; -- Negative value
		rs2 <= "00001"; -- Positive value
		rd <= "01010"; -- Use a different destination register
		mem_write <= '0';
		mem_read <= '0';
		data_in <= (others => '0');

    WAIT;
END PROCESS;

-- ... (remaining code)


END behavior;
