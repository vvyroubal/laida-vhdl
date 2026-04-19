library ieee;
use ieee.std_logic_1164.all;

-- D flip-flop with synchronous reset (rising edge triggered)
entity d_flip_flop is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        d   : in  std_logic;
        q   : out std_logic;
        q_n : out std_logic
    );
end entity;

architecture rtl of d_flip_flop is
    signal q_int : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                q_int <= '0';
            else
                q_int <= d;
            end if;
        end if;
    end process;

    q   <= q_int;
    q_n <= not q_int;
end architecture;
