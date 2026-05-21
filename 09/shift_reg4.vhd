library ieee;
use ieee.std_logic_1164.all;

entity shift_reg4 is
    port (
        clk  : in  std_logic;
        d_in : in  std_logic;
        q    : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of shift_reg4 is
    signal reg : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            reg <= reg(2 downto 0) & d_in;  -- pomak ulijevo, novi bit ulazi na LSB
        end if;
    end process;

    q <= reg;
end architecture;
