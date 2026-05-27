-- Mooreov upravljač semafora s 4-faznim ciklusom.
-- Ulaz TICK je puls iz vanjskog tajmera (npr.\ 1 Hz); na uzlaznom bridu takta
-- s TICK = 1 automat napreduje u sljedeću fazu.
-- Izlazi r, y, g pojedinačno upravljaju crvenom, žutom i zelenom lampom.
-- Kodiranje stanja je Grayevo (CRVENO=00, CRVENO_ZUTO=01, ZELENO=11, ZUTO=10),
-- ali sintetski alat radi izravno s nabrojanim tipom.

library ieee;
use ieee.std_logic_1164.all;

entity semafor is
    port (
        clk, rst : in  std_logic;
        tick     : in  std_logic;
        r, y, g  : out std_logic
    );
end entity;

architecture troprocesni of semafor is
    type state_t is (CRVENO, CRVENO_ZUTO, ZELENO, ZUTO);
    signal state, state_next : state_t;
begin
    -- Registar stanja (asinkroni reset)
    reg: process (clk, rst)
    begin
        if rst = '1' then
            state <= CRVENO;
        elsif rising_edge(clk) then
            state <= state_next;
        end if;
    end process;

    -- Funkcija prijelaza (delta)
    nsl: process (state, tick)
    begin
        state_next <= state;
        if tick = '1' then
            case state is
                when CRVENO      => state_next <= CRVENO_ZUTO;
                when CRVENO_ZUTO => state_next <= ZELENO;
                when ZELENO      => state_next <= ZUTO;
                when ZUTO        => state_next <= CRVENO;
            end case;
        end if;
    end process;

    -- Izlazna funkcija (Moore: ovisi samo o stanju)
    out_logic: process (state)
    begin
        r <= '0'; y <= '0'; g <= '0';
        case state is
            when CRVENO      => r <= '1';
            when CRVENO_ZUTO => r <= '1'; y <= '1';
            when ZELENO      => g <= '1';
            when ZUTO        => y <= '1';
        end case;
    end process;
end architecture;
