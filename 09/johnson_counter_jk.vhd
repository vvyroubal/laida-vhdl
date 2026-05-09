library ieee;
use ieee.std_logic_1164.all;

entity johnson_counter_jk is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of johnson_counter_jk is
    signal reg : std_logic_vector(3 downto 0) := (others => '0');
    signal j3, k3, j2, k2, j1, k1, j0, k0 : std_logic;
begin
    -- FF0: J0 = not Q3, K0 = Q3  (J and K swapped -- no inverter gate needed)
    j0 <= not reg(3);  k0 <= reg(3);
    -- FF1, FF2, FF3: same as ring counter
    j1 <= reg(0);  k1 <= not reg(0);
    j2 <= reg(1);  k2 <= not reg(1);
    j3 <= reg(2);  k3 <= not reg(2);

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg <= (others => '0');
            else
                -- JK next-state equation: Q_next = J AND NOT Q OR NOT K AND Q
                reg(0) <= (j0 and not reg(0)) or (not k0 and reg(0));
                reg(1) <= (j1 and not reg(1)) or (not k1 and reg(1));
                reg(2) <= (j2 and not reg(2)) or (not k2 and reg(2));
                reg(3) <= (j3 and not reg(3)) or (not k3 and reg(3));
            end if;
        end if;
    end process;

    q <= reg;
end architecture;
