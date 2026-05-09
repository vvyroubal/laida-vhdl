library ieee;
use ieee.std_logic_1164.all;

entity tb_seq_gen is
end entity;

architecture sim of tb_seq_gen is
    signal clk, rst     : std_logic := '0';
    signal q_vec        : std_logic_vector(2 downto 0);
    signal q0, q1, q2   : std_logic;

    constant T : time := 10 ns;
begin
    uut: entity work.seq_gen
        port map(clk => clk, rst => rst, q => q_vec);

    q0 <= q_vec(0);
    q1 <= q_vec(1);
    q2 <= q_vec(2);

    clk <= not clk after T / 2;

    process
    begin
        rst <= '1';  wait for 2 * T;   -- 2 clock cycles of reset
        rst <= '0';  wait for 18 * T;  -- 3 complete 6-state Gray-code cycles
        wait;
    end process;
end architecture;
