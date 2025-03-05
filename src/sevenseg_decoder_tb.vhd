
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
    signal wo_seg_n : std_logic_vector (6 downto 0);

begin
    -- Instantiate the sevenseg_decoder
    sevenseg_decoder_inst : sevenseg_decoder port map (
    
            i_Hex  => i_Hex_tb,
            o_seg_n => wo_seg_n
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
