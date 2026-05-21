library ieee;
use ieee.std_logic_1164.all;

-- Mealyev detektor niza "1011"
-- Izlaz Z=1 (kombinacijski) kada se niz završi u trenutnom taktu
-- Kodiranje stanja: S0=00, S1=01, S2=10, S3=11
entity seq_det is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        x   : in  std_logic;
        z   : out std_logic
    );
end entity;

architecture rtl of seq_det is
    signal state : std_logic_vector(1 downto 0) := "00";
begin
    -- Registar stanja
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= "00";
            else
                case state is
                    when "00" =>                    -- S0: početno
                        if x = '1' then state <= "01"; end if;
                    when "01" =>                    -- S1: primljeno "1"
                        if x = '0' then state <= "10"; end if;
                    when "10" =>                    -- S2: primljeno "10"
                        if x = '1' then state <= "11";
                        else            state <= "00"; end if;
                    when "11" =>                    -- S3: primljeno "101"
                        if x = '1' then state <= "01";
                        else            state <= "10"; end if;
                    when others => state <= "00";
                end case;
            end if;
        end if;
    end process;

    -- Mealyev izlaz: kombinacijski, Z=1 kada se niz "1011" završi
    z <= '1' when (state = "11" and x = '1') else '0';
end architecture;
