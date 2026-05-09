library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry_adder is
    generic (N : positive := 4);
    port (
        a, b  : in  std_logic_vector(N-1 downto 0);
        cin   : in  std_logic;
        sum   : out std_logic_vector(N-1 downto 0);
        cout  : out std_logic
    );
end entity;

architecture rtl of ripple_carry_adder is
    signal carry : std_logic_vector(N downto 0);
begin
    carry(0) <= cin;

    gen_fa: for i in 0 to N-1 generate
        fa_i: entity work.full_adder
            port map(
                a    => a(i),
                b    => b(i),
                cin  => carry(i),
                sum  => sum(i),
                cout => carry(i+1)
            );
    end generate;

    cout <= carry(N);
end architecture;
