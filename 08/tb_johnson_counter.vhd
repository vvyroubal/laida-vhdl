library ieee;
use ieee.std_logic_1164.all;

entity tb_johnson_counter is
end entity;

architecture sim of tb_johnson_counter is
    signal clk, rst : std_logic := '0';
    signal q_vec    : std_logic_vector(3 downto 0);
    signal q3, q2, q1, q0 : std_logic;

    constant T : time := 10 ns;
begin
    uut: entity work.johnson_counter
        port map(clk => clk, rst => rst, q => q_vec);

    q3 <= q_vec(3);
    q2 <= q_vec(2);
    q1 <= q_vec(1);
    q0 <= q_vec(0);

    clk <= not clk after T / 2;

    process
    begin
        rst <= '1';  wait for 2 * T;
        rst <= '0';
        -- two full Johnson cycles (8 states × 2)
        wait for 16 * T;
        rst <= '1';  wait for T;
        rst <= '0';  wait for 4 * T;
        wait;
    end process;
end architecture;
