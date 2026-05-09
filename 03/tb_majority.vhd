library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_majority is
end entity;

architecture sim of tb_majority is
    signal a, b, c, y : std_logic;

    type expected_t is array(0 to 7) of std_logic;
    constant EXP : expected_t :=
        ('0','0','0','1','0','1','1','1');
begin
    DUT: entity work.majority(rtl)
        port map(a => a, b => b, c => c, y => y);

    process
        variable input : unsigned(2 downto 0);
    begin
        for i in 0 to 7 loop
            input := to_unsigned(i, 3);
            a <= input(2); b <= input(1); c <= input(0);
            wait for 10 ns;
            assert y = EXP(i)
                report "ERROR on combination " & integer'image(i)
                severity error;
        end loop;
        report "Simulation complete." severity note;
        wait;
    end process;
end architecture;
