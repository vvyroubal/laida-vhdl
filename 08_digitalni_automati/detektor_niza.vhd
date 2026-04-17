library ieee;
use ieee.std_logic_1164.all;

-- Moore automat: detektor niza "101"
-- Stanja: S0 (pocetak), S1 (primljeno '1'),
--         S2 (primljeno '10'), S3 (primljeno '101' -> y='1')
entity detektor_niza is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        x   : in  std_logic;
        y   : out std_logic
    );
end entity;

architecture rtl of detektor_niza is
    type stanje_t is (S0, S1, S2, S3);
    signal stanje : stanje_t := S0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                stanje <= S0;
            else
                case stanje is
                    when S0 =>
                        if x = '1' then stanje <= S1; else stanje <= S0; end if;
                    when S1 =>
                        if x = '0' then stanje <= S2; else stanje <= S1; end if;
                    when S2 =>
                        if x = '1' then stanje <= S3; else stanje <= S0; end if;
                    when S3 =>
                        if x = '1' then stanje <= S1; else stanje <= S2; end if;
                end case;
            end if;
        end if;
    end process;

    y <= '1' when stanje = S3 else '0';
end architecture;
