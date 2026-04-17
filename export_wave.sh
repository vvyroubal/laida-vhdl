#!/bin/bash
# Headless GTKWave PNG export putem PostScript konverzije
# Usage: export_wave.sh <vcd_file>
set -e

VCD="$1"
PNG="${VCD%.vcd}.png"
PS_TMP=$(mktemp /tmp/gtkwave_XXXXX.ps)
RC_TMP=$(mktemp /tmp/gtkwaverc_XXXXX)

# rc: print na datoteku bez dijaloga
cat > "$RC_TMP" << EOF
print_to_file 1
print_to_filename $PS_TMP
EOF

# Tcl: dodaj signale, zoom, print, quit
SCRIPT_TMP=$(mktemp /tmp/gtkwave_XXXXX.tcl)
cat > "$SCRIPT_TMP" << 'EOF'
set nfacs [gtkwave::getNumFacs]
for {set i 0} {$i < $nfacs} {incr i} {
    gtkwave::addSignalsFromList [gtkwave::getFacName $i]
}
gtkwave::/Time/Zoom/Zoom_Full
after 300
gtkwave::/File/Print_To_File
gtkwave::/File/Quit
EOF

gtkwave --rcfile="$RC_TMP" "$VCD" -S "$SCRIPT_TMP" 2>/dev/null

# Konvertiraj PS -> PNG
gs -dNOPAUSE -dBATCH -sDEVICE=png16m -r120 -sOutputFile="$PNG" "$PS_TMP" 2>/dev/null

rm -f "$PS_TMP" "$RC_TMP" "$SCRIPT_TMP"
echo "Exported: $PNG"
