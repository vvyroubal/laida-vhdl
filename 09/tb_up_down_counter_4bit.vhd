-- Testbench za 4-bitno binarno brojilo gore/dolje.
-- Nakon reseta broji unaprijed kroz cijeli 16-stanjski ciklus do 0,
-- zatim mijenja smjer i broji unatrag kroz cijeli novi ciklus.
-- Svako stanje provjerava se pomoću assert.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_up_down_counter_4bit is
end entity;

architecture sim of tb_up_down_counter_4bit is

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal dir : std_logic := '0';
    signal q   : std_logic_vector(3 downto 0);

    constant period : time := 20 ns;

begin

    dut : entity work.up_down_counter_4bit
        port map (clk => clk, rst => rst, dir => dir, q => q);

    clk_gen : process
    begin
        wait for period/2;
        clk <= not clk;
    end process;

    stim : process
    begin
        -- Reset, smjer unaprijed
        rst <= '1'; dir <= '0';
        wait for period;
        assert q = "0000" report "Stanje nakon reseta mora biti 0"
            severity error;
        rst <= '0';

        -- Provjera brojanja unaprijed: 1, 2, ..., 15, 0
        for i in 1 to 16 loop
            wait until rising_edge(clk);
            wait for 1 ns;
            assert unsigned(q) = to_unsigned(i mod 16, 4)
                report "Brojanje unaprijed " & integer'image(i mod 16) &
                       " ne odgovara"
                severity error;
        end loop;

        -- Promjena smjera: sada je Q=0, broji unatrag: 15, 14, ..., 1, 0
        dir <= '1';
        for i in 1 to 16 loop
            wait until rising_edge(clk);
            wait for 1 ns;
            assert unsigned(q) = to_unsigned((16 - i) mod 16, 4)
                report "Brojanje unatrag " & integer'image((16 - i) mod 16) &
                       " ne odgovara"
                severity error;
        end loop;

        report "Brojilo gore/dolje ispravno provjereno" severity note;
        wait;
    end process;

end architecture;
