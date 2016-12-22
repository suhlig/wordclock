# Ruby Word Clock

![Front](doc/front.jpg) ![Back](doc/back.jpg)

This is an implementation of a [Word Clock](http://www.instructables.com/id/Wordclock/) in Ruby. It maps every point in time between 0:01 and midnight to a sentence, which is represented as positions of pixels to light up. The positions are for a single, continuous strip of LEDs. The current implementation uses German words.

The LEDs are driven by a [Fadecandy](https://github.com/scanlime/fadecandy) board using [faderuby](https://github.com/JamesHarrison/faderuby).

The hardware setup was largely inspired by the [WordClock mit WS2812](https://www.mikrocontroller.net/articles/WordClock_mit_WS2812) article at [mikrocontroller.net](https://www.mikrocontroller.net/).

# LED Indices

Read from top to bottom, with MSB in the top row:

```                                                                                                 1         1         1         1         1         1         1         1         1         1         2         2         2         2         2         2         2         2         2
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
ESAISTOVIERTELEINSDREINERSECHSIEBENEELFÜNFNEUNVIERACHTNULLZWEINZWÖLFZEHNUNDOZWANZIGVIERZIGDREISSIGFÜNFZIGUHRMINUTENIVORUNDNACHEINDREIVIERTELHALBSIEBENEUNULLZWEINEFÜNFSECHSNACHTVIERDREINSUNDAELFEZEHNZWANZIGGRADREISSIGVIERZIGZWÖLFÜNFZIGMINUTENUHREFRÜHVORABENDSMITTERNACHTSMORGENSWARMMITTAGS
```

# Development

This is a regular Ruby project, i.e. after cloning the project, the usual

```bash
$ bundle install
$ bundle exec rake
```

will get you started with running the tests.

# Deployment

See [deployment](deployment/README.markdown) for details.

# Troubleshooting the WS2811B LEDs

## Wiring

I accidentally killed a number of LEDs with a ground loop because the Raspberry Pi and the soldering iron were connected to different wall sockets.

To find out whether an LED is dead, someone in [the forum](https://www.mikrocontroller.net/topic/385955) recommended to measure the resistance between `DATA` and `GND`:

* If the resistance is between 2 and 15 MΩ, the LED is ok.
* If the resistance is ∞, the LED is dead.

Since then, this is my safety procedure when soldering LEDs:

1. Connect `GND` of soldering iron to `GND` of the LED strip to be soldered
1. Connect `GND` of power supply to `GND` of the LED strip to be soldered
1. Solder black wire to `GND` of LED strip
1. Solder red wire to `+5V` of LED strip
1. Connect `GND` of Fadecandy to LED strip
1. Connect `DATA` of Fadecandy to LED strip
1. Connect Fadecandy to USB
1. Connect `+5V` of power supply to LED strip
1. Start test

## Software Tests

* `grow.rb` is nice because it highlights the first and last LED)

* Also useful:

  ```bash
  $ cd ~/workspace/fadecandy/examples/perl
  $ ./random.pl; ./turnthemoff.pl
  ```

  Having `random.pl` and `turnthemoff.pl` in one line ensures that all LEDs are turned off when `random.pl` is interrupted.

* Tailing the log file

  ```bash
  ssh wordclock sudo journalctl -u fcserver -f
  ```

  Once a client connects, it will show a line similar to this:

  ```
  Dec 17 18:07:52 wordclock fcserver[684]: [1481994472:2735] NOTICE: New Open Pixel Control connection
  ```

# Bill of Materials

## Electronics Parts

| Component |   Price |
| :-------- | ------: |
| [300 WS2811B LEDs](https://www.ebay.de/itm/222192610445) | 33,21 € |
| [Adafruit FadeCandy](http://www.exp-tech.de/adafruit-fadecandy-dithering-usb-controlled-driver-for-neopixels) Dithering USB-Controlled Driver for NeoPixels | 28,45 € |
| [Raspberry Pi 3 Model B](https://www.amazon.de/dp/B01CEFWQFA/) | 34,99 € |
| [SanDisk Ultra Android microSDHC 16GB](https://www.amazon.de/dp/B013UDL5V6/) | 7,99 € |
| [MeanWell LED-Netzteil 5V](https://www.ebay.de/itm/310840219652) | 37,00 € |
| [Kabel USB 2.0 Micro B Stecker auf 2x offene Kabelenden](https://www.amazon.de/dp/B01A9GLG6Q/) | 1,49 € |

## Mechanical Parts

| Component |   Price |
| :-------- | ------: |
| [Back plane](https://www.ebay.de/itm/301477115708) for mouting the LEDs | 7,88 € |
| [Front plane](https://www.mikrocontroller.net/articles/WordClock_mit_WS2812#WC24h_Sammelbestellung_Frontplatten) |  54,00 € |
| [Mounting plane](https://www.mikrocontroller.net/articles/WordClock_mit_WS2812#WC24h_Sammelbestellung_Zwischenb.C3.B6den) | 59,50 € |
| [Picture frame](https://www.alutech.de/alu---zuschnitt-profil-18.html) (incl. mounting set) | 42,48 € |
| [Cable box](https://www.amazon.de/dp/B01C6V7OP4/) | 12,99 € |

All prices as of Sept. 2016 incl. S&H.
