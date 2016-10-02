# Ruby Word Clock

This is an implementation of a [Word Clock](http://www.instructables.com/id/Wordclock/) in Ruby. It maps every point in time between 0:01 and midnight to a sentence, which is represented as positions of pixels to light up. The positions are for a single, continuous strip of LEDs. The current implementation uses German words.

The LEDs are driven by a [Fadecandy](https://github.com/scanlime/fadecandy) board using [faderuby](https://github.com/JamesHarrison/faderuby).

# Test Matrix

The following matrix marks all cases that are covered by a test with an 'x':

   | 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59
===|====================================================================================================================================================================================
00 |  x  x  x  x  x  x  x  x  x  x  x           x  x  x                                      x  x  x
01 |  x                                                                                         x
02 |
03 |
04 |
05 |
06 |                                            x
07 |
08 |
09 |
10 |
11 |
12 |
13 |
14 |
15 |
16 |
17 |
18 |
19 |
20 |
21 |
22 |
23 |
