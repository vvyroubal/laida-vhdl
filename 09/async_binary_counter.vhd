library ieee;
use ieee.std_logic_1164.all;

-- 4-bit asynchronous (ripple) binary counter with asynchronous reset
-- Built from T flip-flops; Q(i) clocks the next stage on its falling edge
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

    -- Stage 0: clocked by main CLK (falling edge)
    process(clk, rst)
    begin
        if rst = '1' then
            q_int(0) <= '0';
        elsif falling_edge(clk) then
            q_int(0) <= not q_int(0);
        end if;
    end process;

    -- Stage 1: clocked by Q0 falling edge (ripple)
    process(q_int(0), rst)
    begin
        if rst = '1' then
            q_int(1) <= '0';
        elsif falling_edge(q_int(0)) then
            q_int(1) <= not q_int(1);
        end if;
    end process;

    -- Stage 2: clocked by Q1 falling edge (ripple)
    process(q_int(1), rst)
    begin
        if rst = '1' then
            q_int(2) <= '0';
        elsif falling_edge(q_int(1)) then
            q_int(2) <= not q_int(2);
        end if;
    end process;

    -- Stage 3: clocked by Q2 falling edge (ripple)
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
