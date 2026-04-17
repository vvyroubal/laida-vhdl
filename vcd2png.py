#!/usr/bin/env python3
"""
Headless VCD -> PNG renderer za LAiDA udžbenik.
Koristi Agg matplotlib backend — ne treba display.
"""
import sys
import os
import re
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from vcdvcd import VCDVCD


def sig_label(full_name):
    """Skrati putanju signala na ime entiteta + signal."""
    parts = full_name.split(".")
    return ".".join(parts[-2:]) if len(parts) > 1 else full_name


def parse_logic(val):
    """Pretvori std_logic vrijednost u float za crtanje."""
    if val in ("1",):
        return 1.0
    if val in ("0",):
        return 0.0
    return 0.5  # U, X, Z -> sredina


def render(vcd_path, png_path, scale_ns=1):
    vcd = VCDVCD(vcd_path, store_tvs=True)

    signals = [s for s in vcd.signals if "tb_" not in s.split(".")[-1].lower()]
    if not signals:
        signals = vcd.signals

    n = len(signals)
    fig, axes = plt.subplots(n, 1, figsize=(14, max(n * 0.9, 3)),
                             sharex=True)
    if n == 1:
        axes = [axes]

    fig.patch.set_facecolor("#1e1e2e")
    colors = {"1": "#a6e3a1", "0": "#89b4fa", "other": "#f38ba8"}

    end_time = vcd.endtime
    x_scale = 1e-9 if scale_ns else 1

    for ax, sig_name in zip(axes, signals):
        sig = vcd[sig_name]
        tv = sig.tv

        times = [t for t, _ in tv] + [end_time]
        vals  = [parse_logic(v) for _, v in tv] + [parse_logic(tv[-1][1])]

        ax.step(times, vals, where="post", color="#cdd6f4", linewidth=1.5)
        ax.fill_between(times, vals, step="post", alpha=0.15, color="#89b4fa")

        ax.set_ylim(-0.15, 1.15)
        ax.set_yticks([0, 1])
        ax.set_yticklabels(["0", "1"], fontsize=7, color="#cdd6f4")
        ax.set_ylabel(sig_label(sig_name), rotation=0, ha="right",
                      fontsize=8, color="#cdd6f4", labelpad=60)
        ax.set_facecolor("#181825")
        ax.tick_params(axis="x", colors="#585b70")
        ax.spines[:].set_color("#313244")

    axes[-1].set_xlabel("Vrijeme (ns)", color="#cdd6f4", fontsize=9)
    axes[-1].xaxis.set_major_formatter(
        ticker.FuncFormatter(lambda x, _: f"{x/1e6:.0f}")
    )

    plt.tight_layout(h_pad=0.3)
    plt.savefig(png_path, dpi=150, bbox_inches="tight",
                facecolor=fig.get_facecolor())
    plt.close()
    print(f"Exported: {png_path}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <file.vcd> [output.png]")
        sys.exit(1)
    vcd_in  = sys.argv[1]
    png_out = sys.argv[2] if len(sys.argv) > 2 else vcd_in.replace(".vcd", ".png")
    render(vcd_in, png_out)
