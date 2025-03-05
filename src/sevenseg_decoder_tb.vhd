library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Required for to_unsigned function

entity sevenseg_decoder_tb is
    -- Testbench does NOT have input/output ports
end sevenseg_decoder_tb;

architecture testbench of sevenseg_decoder_tb is
    -- Component declaration for the Unit Under Test (UUT)
    component sevenseg_decoder
        Port (
            i_Hex  : in  std_logic_vector (3 downto 0);
            o_seg_n : out std_logic_vector (6 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal i_Hex_tb  : std_logic_vector (3 downto 0);
    signal o_seg_n_tb : std_logic_vector (6 downto 0);

    -- Array of expected outputs for inputs 0 to F
    type slv_array is array (0 to 15) of std_logic_vector(6 downto 0);
    constant expected_outputs: slv_array := (
        "1000000", -- 0
        "1111001", -- 1
        "0100100", -- 2
        "0110000", -- 3
        "0011001", -- 4
        "0010010", -- 5
        "0000010", -- 6
        "1111000", -- 7
        "0000000", -- 8
        "0010000", -- 9
        "0001000", -- A
        "0000011", -- B
        "1000110", -- C
        "0100001", -- D
        "0000110", -- E
        "0001110"  -- F
    );

    -- Function to convert std_logic_vector to string for reporting
    function slv_to_string(slv: std_logic_vector) return string is
        variable result: string(1 to slv'length);
    begin
        for i in slv'range loop
            if slv(i) = '1' then
                result(i + 1) := '1';
            else
                result(i + 1) := '0';
            end if;
        end loop;
        return result;
    end function;

begin
    -- Instantiate the sevenseg_decoder
    sevenseg_decoder_inst : sevenseg_decoder port map (
        i_Hex  => i_Hex_tb,
        o_seg_n => o_seg_n_tb
    );

    -- Stimulus process
    test_process : process
    begin
        -- Iterate through all possible 4-bit values (0 to F)
        for i in 0 to 15 loop
            i_Hex_tb <= std_logic_vector(to_unsigned(i, 4));  -- Convert integer to std_logic_vector
            wait for 10 ns;  -- Wait time for each test 

            -- Check if output matches expected value
            assert (o_seg_n_tb = expected_outputs(i))
                report "Error: Input = x""" & integer'image(i) & """ produced output = " &
                       slv_to_string(o_seg_n_tb) & ", expected = " &
                       slv_to_string(expected_outputs(i))
                severity error;
        end loop;

        -- End simulation after all cases are tested
        wait;
    end process;

end testbench;
