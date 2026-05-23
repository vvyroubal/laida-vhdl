-- Modulo-6 brojilo s nestandardnim slijedom 0 -> 3 -> 7 -> 6 -> 1 -> 0.
-- Nedefinirana stanja (2, 4, 5) preusmjeravaju se u stanje 6 pri sljedećem
-- bridu takta (mehanizam sigurnog starta).

library ieee;
use ieee.std_logic_1164.all;

entity modulo6_counter is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(2 downto 0)
    );
end entity;

architecture rtl of modulo6_counter is
    signal stanje : std_logic_vector(2 downto 0) := "000";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                stanje <= "000";
            else
                case stanje is
                    when "000" => stanje <= "011";  -- 0 -> 3
                    when "011" => stanje <= "111";  -- 3 -> 7
                    when "111" => stanje <= "110";  -- 7 -> 6
                    when "110" => stanje <= "001";  -- 6 -> 1
                    when "001" => stanje <= "000";  -- 1 -> 0
                    when others => stanje <= "110"; -- siguran start: 2/4/5 -> 6
                end case;
            end if;
        end if;
    end process;

    q <= stanje;
end architecture;
