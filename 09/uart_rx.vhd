-- UART prijamnik (RX), FSMD arhitektura.
-- Pojednostavljenja:
--   * 1 takt = 1 bit (nema 16x oversamplinga; takt mora biti baud rate)
--   * 8 podatkovnih bita, bez parnosti, 1 stop bit (UART 8N1)
--   * Sinkroni dolazak okvira (pretpostavlja ulaznu sinkronizaciju)
-- FSM ima 3 stanja: IDLE, RECEIVE, STOP.
-- Datapath: 8-bitni posmacni registar i 3-bitni brojac bita.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is
    port (
        clk, rst : in  std_logic;
        rx       : in  std_logic;
        data     : out std_logic_vector(7 downto 0);
        valid    : out std_logic
    );
end entity;

architecture fsmd of uart_rx is
    type state_t is (IDLE, RECEIVE, STOP);
    signal state, state_next         : state_t;
    signal shift_reg, shift_reg_next : std_logic_vector(7 downto 0);
    signal bit_cnt, bit_cnt_next     : unsigned(2 downto 0);
begin
    -- Sekvencijalni proces: registar stanja + datapath registri
    reg: process (clk, rst)
    begin
        if rst = '1' then
            state     <= IDLE;
            shift_reg <= (others => '0');
            bit_cnt   <= (others => '0');
        elsif rising_edge(clk) then
            state     <= state_next;
            shift_reg <= shift_reg_next;
            bit_cnt   <= bit_cnt_next;
        end if;
    end process;

    -- Kombinacijski proces: funkcija prijelaza + datapath operacije
    nsl: process (state, rx, shift_reg, bit_cnt)
    begin
        -- defaults: zadrzi
        state_next     <= state;
        shift_reg_next <= shift_reg;
        bit_cnt_next   <= bit_cnt;

        case state is
            when IDLE =>
                if rx = '0' then                       -- detektiran start bit
                    state_next   <= RECEIVE;
                    bit_cnt_next <= (others => '0');   -- pripremi brojac
                end if;

            when RECEIVE =>
                -- Pomakni rx u MSB; LSB-first prijenos znaci da prvi
                -- primljen bit (b0) zavrsava na poziciji 0 nakon 8 pomaka.
                shift_reg_next <= rx & shift_reg(7 downto 1);
                if bit_cnt = 7 then
                    state_next <= STOP;                -- zadnji data bit primljen
                else
                    bit_cnt_next <= bit_cnt + 1;
                end if;

            when STOP =>
                state_next <= IDLE;                    -- uvijek natrag u IDLE
        end case;
    end process;

    -- Izlazi (Mealy-tipa za valid: ovisi o stanju i ulazu rx)
    data  <= shift_reg;
    valid <= '1' when (state = STOP and rx = '1') else '0';
end architecture;
