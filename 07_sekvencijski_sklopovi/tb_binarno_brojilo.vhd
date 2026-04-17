library ieee;
use ieee.std_logic_1164.all;

entity tb_binarno_brojilo is
end entity;

architecture sim of tb_binarno_brojilo is
    signal clk, rst : std_logic := '0';
    signal q        : std_logic_vector(3 downto 0);

    constant T : time := 10 ns;
begin
    uut: entity work.binarno_brojilo
        port map(clk => clk, rst => rst, q => q);

    clk <= not clk after T / 2;

    process
    begin
        rst <= '1';  wait for 2 * T;
        rst <= '0';
        -- prebrojimo 20 taktova (prelaz iz 0 do 15, pa prekoracenje)
        wait for 20 * T;
        rst <= '1';  wait for T;
        rst <= '0';  wait for 5 * T;
        wait;
    end process;
end architecture;
