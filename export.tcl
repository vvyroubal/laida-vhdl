# GTKWave headless PNG export
# Dodaje sve signale, zoom na puni raspon, eksportira PNG, izlazi.

set nfacs [gtkwave::getNumFacs]
for {set i 0} {$i < $nfacs} {incr i} {
    gtkwave::addSignalsFromList [gtkwave::getFacName $i]
}

gtkwave::/Time/Zoom/Zoom_Full

after 500

set vcd [gtkwave::getDumpFileName]
set png [regsub {\.vcd$} $vcd ".png"]

gtkwave::/File/Grab_To_File $png

gtkwave::/File/Quit
