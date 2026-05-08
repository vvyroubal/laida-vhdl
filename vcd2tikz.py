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
    import re
    if name.lower() in ("qn", "q_n", "qbar", "nq"):
        return r"$\bar{\mathrm{Q}}$"
    # q3 → Q_3, clk2 → CLK_2, etc.
    m = re.match(r'^([a-zA-Z_]+?)(\d+)$', name)
    if m:
        letters = m.group(1).upper().replace("_", "")
        digit   = m.group(2)
        return rf"$\mathrm{{{letters}}}_{{{digit}}}$"
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


def build_state_row(sig_names, vcd, global_end, unit):
    """Generate D{n} decimal-state annotation row when ≥2 consecutive q-bit signals are present."""
    import re
    bit_sigs = {}
    for sig in sig_names:
        short = sig_shortname(sig).lower()
        m = re.match(r'^q(\d)$', short)
        if m:
            bit_sigs[int(m.group(1))] = sig
    if len(bit_sigs) < 2:
        return None

    n_bits = max(bit_sigs.keys()) + 1

    # Merge all bit-signal events into a single timeline {time → {bit: val}}
    timeline = {}
    for b, sig in bit_sigs.items():
        for t, v in vcd[sig].tv:
            timeline.setdefault(t, {})[b] = v

    cur = {}
    parts = []
    prev_t = 0
    prev_label = None

    def decode(c):
        vals = [c.get(b, '0') for b in range(n_bits)]
        return str(sum(int(v) << b for b, v in enumerate(vals))) if all(v in ('0', '1') for v in vals) else '?'

    for t in sorted(timeline):
        if prev_label is not None and t > prev_t:
            n = round((t - prev_t) / unit)
            if n > 0:
                parts.append(f"{n}D{{{prev_label}}}")
        cur.update(timeline[t])
        prev_label = decode(cur)
        prev_t = t

    if prev_label is not None:
        n = round((global_end - prev_t) / unit)
        if n > 0:
            parts.append(f"{n}D{{{prev_label}}}")

    msb = n_bits - 1
    row_label = "{$Q_{" + str(msb) + ":0}$}"
    return f"  {row_label}    & " + " ".join(parts) + r" \\"


def vcd_to_tikztiming(vcd_path):
    vcd = VCDVCD(vcd_path, store_tvs=True)
    end_time = vcd.endtime

    # Zadrži samo signale na najplićoj razini hierarhije (filtrira UUT-interne)
    all_sigs = list(vcd.signals)
    if not all_sigs:
        return ""
    min_depth = min(len(s.split(".")) for s in all_sigs)
    sig_names = [s for s in all_sigs if len(s.split(".")) == min_depth]

    # Ako testbench eksplicitno izlaže individualne bitove (q3, q2, ...), preskoči bus
    # signale (npr. q_vec[3:0]) kako bi se izbjegla redundancija.
    import re as _re
    short_names = [sig_shortname(s) for s in sig_names]
    has_bit_signals = any(
        _re.search(r'\d$', n) and '[' not in n for n in short_names
    )
    if has_bit_signals:
        sig_names = [s for s in sig_names if '[' not in sig_shortname(s)]

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

    state_row = build_state_row(sig_names, vcd, global_end, unit)
    if state_row:
        rows.append(state_row)

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
