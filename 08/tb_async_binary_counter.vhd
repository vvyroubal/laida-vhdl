library ieee;
use ieee.std_logic_1164.all;

entity tb_async_binary_counter is
end entity;

architecture sim of tb_async_binary_counter is
    signal clk, rst         : std_logic := '0';
    signal q_vec            : std_logic_vector(3 downto 0);
    signal q0, q1, q2, q3  : std_logic;

    constant T : time := 10 ns;
begin
    uut: entity work.async_binary_counter
        port map(clk => clk, rst => rst, q => q_vec);

    q0 <= q_vec(0);
    q1 <= q_vec(1);
    q2 <= q_vec(2);
    q3 <= q_vec(3);

    clk <= not clk after T / 2;

    process
    begin
        rst <= '1';  wait for 2 * T + T / 2;  -- covers CLK falling edges at t=10 and t=20
        rst <= '0';  wait for 18 * T;          -- two full 16-state cycles visible
        wait;
    end process;
end architecture;
