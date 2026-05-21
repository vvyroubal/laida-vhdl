library ieee;
use ieee.std_logic_1164.all;

-- 4-bitni samopokretajući prstenasti brojač (sinkroni reset)
-- Svako stanje koje nije one-hot forsira brojač u prvo valjano stanje (Q0=1).
entity ring_counter_ss is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of ring_counter_ss is
    signal reg : std_logic_vector(3 downto 0) := "0001";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg <= "0001";                          -- prvo valjano stanje: Q0=1
            elsif reg /= "0001" and reg /= "0010"
              and reg /= "0100" and reg /= "1000" then
                reg <= "0001";                          -- nepravilno: forsiranje u prvo stanje
            else
                reg <= reg(2 downto 0) & reg(3);        -- normalni pomak
            end if;
        end if;
    end process;

    q <= reg;
end architecture;
