#!/usr/bin/env python3
"""VCD → tikz-timing LaTeX fragment za LAiDA udžbenik.

Upotreba:
    python3 vcd2tikz.py <ulaz.vcd> [izlaz.tex]   # spremi u datoteku
    python3 vcd2tikz.py <ulaz.vcd> -              # ispiši na stdout
"""
import sys
from vcdvcd import VCDVCD


def sig_shortname(full_name):
    return full_name.split(".")[-1]


def tex_label(name):
    if name.lower() in ("qn", "q_n", "qbar", "nq"):
        return r"$\bar{\mathrm{Q}}$"
    upper = name.upper().replace("_", "")
    return rf"$\mathrm{{{upper}}}$"


def val_to_sym(v):
    if v == "1":  return "H"
    if v == "0":  return "L"
    if v in ("z", "Z"):  return "Z"
    return "X"  # u, U, x, X → neodređeno


def is_clock(tv, unit):
    """Vraća True ako signal alternira točno svakih `unit` vremenskih jedinica."""
    if len(tv) < 6:
        return False
    vals = [v for _, v in tv]
    if not all(v in ("0", "1") for v in vals):
        return False
    if not all(a != b for a, b in zip(vals, vals[1:])):
        return False
    intervals = [tv[i + 1][0] - tv[i][0] for i in range(len(tv) - 1)]
    return all(abs(d - unit) < unit * 0.01 for d in intervals)


def build_timing(tv, end_time, unit, clock=False):
    """Pretvori (time, value) listu u tikz-timing string.

    Taktni signali se kodiraju kompaktno kao N{LH} ili N{HL}.
    Ostali signali koriste run-length kodiranje (npr. 4H 2L H).
    """
    if clock:
        start_sym = val_to_sym(tv[0][1])
        other_sym = "H" if start_sym == "L" else "L"
        total_units = round((end_time - tv[0][0]) / unit)
        n_pairs, rem = divmod(total_units, 2)
        result = f"{n_pairs}{{{start_sym}{other_sym}}}"
        if rem:
            result += f" {start_sym}"
        return result

    times = [t for t, _ in tv] + [end_time]
    vals  = [v for _, v in tv]
    parts = []
    for i, v in enumerate(vals):
        n = round((times[i + 1] - times[i]) / unit)
        if n == 0:
            continue
        sym = val_to_sym(v)
        parts.append(f"{n}{sym}" if n > 1 else sym)
    return " ".join(parts)


def vcd_to_tikztiming(vcd_path):
    vcd = VCDVCD(vcd_path, store_tvs=True)
    end_time = vcd.endtime

    # Zadrži samo signale na najplićoj razini hierarhije (filtrira UUT-interne)
    all_sigs = list(vcd.signals)
    if not all_sigs:
        return ""
    min_depth = min(len(s.split(".")) for s in all_sigs)
    sig_names = [s for s in all_sigs if len(s.split(".")) == min_depth]

    # Minimalni vremenski korak = jedna tikz-timing jedinica
    all_times = sorted({t for s in sig_names for t, _ in vcd[s].tv})
    if len(all_times) < 2:
        return ""
    diffs = [b - a for a, b in zip(all_times, all_times[1:]) if b > a]
    unit = min(diffs)

    # Globalni end_time: max zadnjeg zabilježenog trenutka po svim signalima
    global_end = max(tv[-1][0] for s in sig_names for tv in [list(vcd[s].tv)] if tv)

    rows = []
    for sig in sig_names:
        tv = list(vcd[sig].tv)
        if not tv:
            continue
        # Ako signal nema zapis na t=0, dodaj 'X' (neodređeno stanje)
        if tv[0][0] > 0:
            tv = [(0, "x")] + tv
        label  = tex_label(sig_shortname(sig))
        clock  = is_clock(tv, unit)
        timing = build_timing(tv, global_end, unit, clock=clock)
        rows.append(f"  {label} & {timing} \\\\")

    return "\\begin{tikztimingtable}\n" + "\n".join(rows) + "\n\\end{tikztimingtable}"


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"Upotreba: {sys.argv[0]} <ulaz.vcd> [izlaz.tex|-]", file=sys.stderr)
        sys.exit(1)

    vcd_in  = sys.argv[1]
    tex_out = sys.argv[2] if len(sys.argv) > 2 else vcd_in.replace(".vcd", "_timing.tex")

    result = vcd_to_tikztiming(vcd_in)

    if tex_out == "-":
        print(result)
    else:
        with open(tex_out, "w") as f:
            f.write(result + "\n")
        print(f"Exported: {tex_out}", file=sys.stderr)
