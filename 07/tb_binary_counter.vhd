library ieee;
use ieee.std_logic_1164.all;

entity tb_binary_counter is
end entity;

architecture sim of tb_binary_counter is
    signal clk, rst : std_logic := '0';
    signal q        : std_logic_vector(3 downto 0);

    constant T : time := 10 ns;
begin
    uut: entity work.binary_counter
        port map(clk => clk, rst => rst, q => q);

    clk <= not clk after T / 2;

    process
    begin
        rst <= '1';  wait for 2 * T;
        rst <= '0';
        -- count 20 clock cycles (0 to 15, then overflow)
        wait for 20 * T;
        rst <= '1';  wait for T;
        rst <= '0';  wait for 5 * T;
        wait;
    end process;
end architecture;
