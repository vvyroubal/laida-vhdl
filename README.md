# LAiDA — VHDL primjeri

VHDL izvorni kod uz udžbenik **Logički i aritmetički sklopovi s digitalnim automatima** (LAiDA).

Datoteke su organizirane po poglavljima i pokrivaju sve sklopove koji se obrađuju u knjizi:
kombinacijska logika, zbrajala, multipleksori, dekoderi, bistabili, registri, brojači i konačni automati.

## Struktura

```
01/   logička vrata, NAND/NOR
03/   kombinacijska logika
05/   zbrajala, oduzimala, komparatori, koderi, dekoderi, MUX
06/   uvod u VHDL — primjeri i testbenchi
07/   SR, JK, D i T bistabili
08/   konačni automati (Moore, Mealy)
09/   registri, prstenasti i Johnsonov brojač, binarni brojači, FSM primjeri
```

## Kloniranje

```bash
git clone https://github.com/vvyroubal/laida-vhdl.git
```

## Simulacija (GHDL)

Analiza i simulacija primjera za Ch06 potpuno zbrajalo:

```bash
cd 06
ghdl -a full_adder.vhd tb_full_adder.vhd
ghdl -e tb_full_adder
ghdl -r tb_full_adder --vcd=wave.vcd
```

Za prikaz valnih oblika koristi [GTKWave](https://gtkwave.sourceforge.net/):

```bash
gtkwave wave.vcd
```

## Docker (preporučeno za Windows)

Ako imaš Docker, sve možeš pokrenuti bez lokalne instalacije GHDL-a:

```bash
docker run --rm -v "${PWD}:/workspace" -w /workspace ghdl/ghdl:ubuntu20-llvm-9 \
    ghdl -a 06/full_adder.vhd 06/tb_full_adder.vhd && \
    ghdl -e tb_full_adder && \
    ghdl -r tb_full_adder --vcd=wave.vcd
```

## Veza s udžbenikom

Svaka VHDL datoteka ima komentar na vrhu koji objašnjava sklop i navodi odgovarajući odjeljak u knjizi.
Udžbenik (PDF): [vvyroubal/LAiDA](https://github.com/vvyroubal/LAiDA)
