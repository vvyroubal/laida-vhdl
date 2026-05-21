library ieee;
use ieee.std_logic_1164.all;

-- 4-bitni asinkroni (kaskadni) binarni brojač s asinkronim resetom
-- Izgrađen od T bistabila; Q(i) okida sljedeći stupanj na silaznom bridu
entity async_binary_counter is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of async_binary_counter is
    signal q_int : std_logic_vector(3 downto 0) := (others => '0');
begin

    -- Stupanj 0: okida glavni CLK (silazni brid)
    process(clk, rst)
    begin
        if rst = '1' then
            q_int(0) <= '0';
        elsif falling_edge(clk) then
            q_int(0) <= not q_int(0);
        end if;
    end process;

    -- Stupanj 1: okida silazni brid Q0 (kaskada)
    process(q_int(0), rst)
    begin
        if rst = '1' then
            q_int(1) <= '0';
        elsif falling_edge(q_int(0)) then
            q_int(1) <= not q_int(1);
        end if;
    end process;

    -- Stupanj 2: okida silazni brid Q1 (kaskada)
    process(q_int(1), rst)
    begin
        if rst = '1' then
            q_int(2) <= '0';
        elsif falling_edge(q_int(1)) then
            q_int(2) <= not q_int(2);
        end if;
    end process;

    -- Stupanj 3: okida silazni brid Q2 (kaskada)
    process(q_int(2), rst)
    begin
        if rst = '1' then
            q_int(3) <= '0';
        elsif falling_edge(q_int(2)) then
            q_int(3) <= not q_int(3);
        end if;
    end process;

    q <= q_int;

end architecture;
