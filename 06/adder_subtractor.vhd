library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_subtractor is
    generic (N : positive := 4);
    port (
        a, b : in  std_logic_vector(N-1 downto 0);
        sub  : in  std_logic;       -- 0 = add, 1 = subtract
        result : out std_logic_vector(N-1 downto 0);
        cout   : out std_logic
    );
end entity;

architecture rtl of adder_subtractor is
    signal b_xor  : std_logic_vector(N-1 downto 0);
    signal sum_ext : unsigned(N downto 0);
begin
    xor_gen: for i in 0 to N-1 generate
        b_xor(i) <= b(i) xor sub;
    end generate;

    sum_ext <= ('0' & unsigned(a)) + ('0' & unsigned(b_xor))
               + ("" & unsigned'("" & sub));

    result <= std_logic_vector(sum_ext(N-1 downto 0));
    cout   <= sum_ext(N);
end architecture;
