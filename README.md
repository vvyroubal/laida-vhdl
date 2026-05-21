# LAiDA — VHDL primjeri

VHDL izvorni kod uz udžbenik **Digitalna tehnika**.

Udžbenik obrađuje logičku algebru i digitalne automate — od osnovnih logičkih vrata i minimizacije Booleovih funkcija do kombinacijskih sklopova, bistabila, registara, brojača i konačnih automata.

Datoteke su organizirane po poglavljima i pokrivaju sve sklopove koji se obrađuju u knjizi:
kombinacijska logika, zbrajala, multipleksori, dekoderi, bistabili, registri, brojači i konačni automati.

## Struktura

```
02/   kombinacijska logika — konverzija u Grayev kod
03/   logičke funkcije, glasačka logika
04/   minimizirana logička funkcija (K-tablica)
06/   zbrajala, oduzimala, komparatori, koderi, dekoderi, MUX — uvod u VHDL
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

Za automatski prikaz svih signala iz VCD datoteke kao PNG sliku koristi priloženu skriptu:

```bash
python3 vcd2png.py wave.vcd wave.png
```

## Docker (preporučeno)

Ako imaš Docker, sve možeš pokrenuti bez lokalne instalacije GHDL-a.

### Izgradnja slike

```bash
docker build -t laida-sim .
```

### Pokretanje svih simulacija

```bash
docker run --rm -v "$(pwd):/workspace" -w /workspace laida-sim make sim
```

VCD datoteke bit će zapisane u `build/*/`.

### Ručna simulacija jednog primjera unutar kontejnera

```bash
docker run --rm -v "$(pwd):/workspace" -w /workspace laida-sim \
    bash -c "mkdir -p build/06 && cd build/06 && \
             ghdl -a ../../06/full_adder.vhd ../../06/tb_full_adder.vhd && \
             ghdl -e tb_full_adder && \
             ghdl -r tb_full_adder --vcd=tb_full_adder.vcd"
```

## Makefile

Repozitorij sadrži `Makefile` s ciljevima:

| Cilj | Opis |
|------|------|
| `make sim` | Pokreće svih 18 testbencha; VCD datoteke u `build/*/` |
| `make clean` | Briše `build/` direktorij |
| `make docker-build` | Gradi Docker sliku `laida-sim` |
| `make docker-sim` | Pokreće `make sim` unutar Docker kontejnera |

## Veza s udžbenikom

Svaka VHDL datoteka ima komentar na vrhu koji objašnjava sklop i navodi odgovarajući odjeljak u knjizi.
Udžbenik (PDF): [vvyroubal/LAiDA](https://github.com/vvyroubal/LAiDA)
