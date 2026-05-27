-- Testbench za UART prijamnik (1 takt = 1 bit).
-- Salje okvir start + 0x55 LSB-first + stop, provjerava valid i data.

library ieee;
use ieee.std_logic_1164.all;

entity tb_uart_rx is
end entity;

architecture sim of tb_uart_rx is
    signal clk, rst, rx : std_logic := '0';
    signal data         : std_logic_vector(7 downto 0);
    signal valid        : std_logic;
    constant T : time := 10 ns;
begin
    uut: entity work.uart_rx
        port map (clk => clk, rst => rst, rx => rx,
                  data => data, valid => valid);

    clk <= not clk after T / 2;

    process
    begin
        -- Reset, idle linija
        rst <= '1';
        rx  <= '1';
        wait for 3 * T;
        rst <= '0';
        wait until falling_edge(clk);
        wait until falling_edge(clk);

        -- Okvir: start + 0x55 LSB-first (b0..b7 = 1,0,1,0,1,0,1,0) + stop
        rx <= '0'; wait until falling_edge(clk);   -- start (IDLE -> RECEIVE)
        rx <= '1'; wait until falling_edge(clk);   -- b0
        rx <= '0'; wait until falling_edge(clk);   -- b1
        rx <= '1'; wait until falling_edge(clk);   -- b2
        rx <= '0'; wait until falling_edge(clk);   -- b3
        rx <= '1'; wait until falling_edge(clk);   -- b4
        rx <= '0'; wait until falling_edge(clk);   -- b5
        rx <= '1'; wait until falling_edge(clk);   -- b6
        rx <= '0'; wait until falling_edge(clk);   -- b7 (RECEIVE -> STOP)

        -- Stop bit: postavi rx na 1, automat je u STOP stanju
        rx <= '1';
        wait for 1 ns;  -- pricekaj da se kombinacijska logika smiri
        assert valid = '1'
            report "STOP: valid mora biti 1 kad je rx=1" severity error;
        assert data = X"55"
            report "STOP: data mora biti 0x55" severity error;

        wait until falling_edge(clk);    -- STOP -> IDLE
        assert valid = '0'
            report "IDLE: valid mora biti 0" severity error;

        rx <= '1';
        wait for 5 * T;

        report "tb_uart_rx: byte 0x55 uspjesno primljen" severity note;
        wait;
    end process;
end architecture;
