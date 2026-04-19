library ieee;
use ieee.std_logic_1164.all;

entity tb_sequence_detector is
end entity;

architecture sim of tb_sequence_detector is
    signal clk, rst, x, y : std_logic := '0';

    constant T : time := 10 ns;

    -- input sequence containing "101" at multiple positions: 1 0 1 1 0 1 0 1
    type sequence_t is array(0 to 7) of std_logic;
    constant INPUT_SEQ : sequence_t := ('1','0','1','1','0','1','0','1');
begin
    uut: entity work.sequence_detector
        port map(clk => clk, rst => rst, x => x, y => y);

    clk <= not clk after T / 2;

    process
    begin
        rst <= '1';  wait for 2 * T;
        rst <= '0';

        for i in INPUT_SEQ'range loop
            x <= INPUT_SEQ(i);
            wait for T;
        end loop;

        wait for 2 * T;
        wait;
    end process;
end architecture;
