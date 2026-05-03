library ieee;
use ieee.std_logic_1164.all;

entity tb_modulo_counter is
end entity;

architecture sim of tb_modulo_counter is
    signal clk, rst        : std_logic := '0';
    signal q_vec           : std_logic_vector(3 downto 0);
    signal q0, q1, q2, q3 : std_logic;

    constant T : time := 10 ns;
begin
    uut: entity work.modulo_counter
        generic map(M => 6)
        port map(clk => clk, rst => rst, q => q_vec);

    q0 <= q_vec(0);
    q1 <= q_vec(1);
    q2 <= q_vec(2);
    q3 <= q_vec(3);

    clk <= not clk after T / 2;

    process
    begin
        rst <= '1';  wait for 2 * T;
        rst <= '0';
        wait for 22 * T;   -- 3 full periods of 6 + 4 extra states
        rst <= '1';  wait for T;
        rst <= '0';  wait for 5 * T;
        wait;
    end process;
end architecture;
