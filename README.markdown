# Ruby Word Clock

This is an implementation of a [Word Clock](http://www.instructables.com/id/Wordclock/) in Ruby. It maps every point in time between 0:01 and midnight to a sentence, which is represented as positions of pixels to light up. The positions are for a single, continuous strip of LEDs. The current implementation uses German words.

The LEDs are driven by a [Fadecandy](https://github.com/scanlime/fadecandy) board using [faderuby](https://github.com/JamesHarrison/faderuby).
