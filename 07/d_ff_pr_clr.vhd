library ieee;
use ieee.std_logic_1164.all;

-- D bistabil s asinkronim postavljanjem (aktivno nisko) i brisanjem (aktivno nisko).
-- PR_N ima prednost pred CLR_N; istodobna aktivacija je arhitekturalno nedefinirana,
-- ali ovaj model razrješava situaciju davanjem prednosti PR_N (Q -> '1').
entity d_ff_pr_clr is
    port (
        clk   : in  std_logic;
        pr_n  : in  std_logic;  -- asinkrono postavljanje, aktivno nisko: Q -> '1'
        clr_n : in  std_logic;  -- asinkrono brisanje,    aktivno nisko: Q -> '0'
        d     : in  std_logic;
        q     : out std_logic;
        q_n   : out std_logic
    );
end entity;

architecture rtl of d_ff_pr_clr is
    signal q_int : std_logic := '0';
begin
    process(clk, pr_n, clr_n)
    begin
        if pr_n = '0' then
            q_int <= '1';
        elsif clr_n = '0' then
            q_int <= '0';
        elsif rising_edge(clk) then
            q_int <= d;
        end if;
    end process;

    q   <= q_int;
    q_n <= not q_int;
end architecture;
