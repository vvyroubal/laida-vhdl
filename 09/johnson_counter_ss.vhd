library ieee;
use ieee.std_logic_1164.all;

-- 4-bitni samopokretajući Johnsonov (twisted ring) brojač (sinkroni reset)
-- Svako stanje koje nije Johnsonovo forsira brojač u prvo valjano stanje (sve nule).
-- Valjana Johnsonova stanja (VHDL Q3Q2Q1Q0): 0000 0001 0011 0111 1111 1110 1100 1000
entity johnson_counter_ss is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of johnson_counter_ss is
    signal reg : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg <= (others => '0');                 -- prvo valjano stanje: sve nule
            elsif reg /= "0000" and reg /= "0001"
              and reg /= "0011" and reg /= "0111"
              and reg /= "1111" and reg /= "1110"
              and reg /= "1100" and reg /= "1000" then
                reg <= (others => '0');                 -- nepravilno: forsiranje u prvo stanje
            else
                reg <= reg(2 downto 0) & (not reg(3)); -- normalna Johnsonova povratna veza
            end if;
        end if;
    end process;

    q <= reg;
end architecture;
