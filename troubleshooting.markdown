# Testen der WS2811B

Hauptproblem: Erdschleife vom Lötkolben killt Dateneingang

Lösung:

1. Massen direkt verbinden
1. Raspberry Pi und LEDs aus dem gleichen Netzteil speisen

Vorgehen:

1. Patchkabel von Lötkolben-Masse an den Draht klemmen, der an GND der LED angelötet werden soll
1. GND-Draht am Ende der LED anlöten und für die Dauer der Lötarbeiten (oder länger) angeklemmt lassen
1. Plusleitung anlöten
1. Daten-GND anklemmen: schwarzes Patchkabel vom Fadecandy zur LED
1. Datenleitung anklemmen: grünes Patchkabel vom Fadecandy zur LED
1. Fadecandy an USB anschließen
1. Strom für LED einschalten
1. Test starten. `grow.rb` is nice because it highlights the first and last LED.

Also useful:

$ cd ~/workspace/fadecandy/examples/perl
$ ./random.pl; ./turnthemoff.pl

Having `random.pl` and `turnthemoff.pl` in one line ensures that all LEDs are turned off when `random.pl` is interrupted.

# Tail the log file

```
ssh wordclock sudo journalctl -u fcserver -f
```

Once a client connects, it will show a line similar to this:

```
Dec 17 18:07:52 wordclock fcserver[684]: [1481994472:2735] NOTICE: New Open Pixel Control connection
```
