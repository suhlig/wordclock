# frozen_string_literal: true
require 'spec_helper'
require 'word_clock/stripe'
require 'shared_examples_for_word_clock'

# Indexes (read from top to bottom, with MSB in the top row)
#                                                                                                     1         1         1         1         1         1         1         1         1         1         2         2         2         2         2         2         2         2         2
#           1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8
# 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
# ESAISTOVIERTELEINSDREINERSECHSIEBENEELFÜNFNEUNVIERACHTNULLZWEINZWÖLFZEHNUNDOZWANZIGVIERZIGDREISSIGFÜNFZIGUHRMINUTENIVORUNDNACHEINDREIVIERTELHALBSIEBENEUNULLZWEINEFÜNFSECHSNACHTVIERDREINSUNDAELFEZEHNZWANZIGGRADREISSIGVIERZIGZWÖLFÜNFZIGMINUTENUHREFRÜHVORABENDSMITTERNACHTSMORGENSWARMMITTAGS
RSpec.describe WordClock::Stripe do
  describe 'es ist mitternacht' do
    it_behaves_like_a_word_clock(
      0,
      0,
      [0, 1, 3, 4, 5, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  describe 'es ist eins nach mitternacht' do
    it_behaves_like_a_word_clock(
      0,
      1,
      [0, 1, 3, 4, 5, 14, 15, 16, 17, 122, 123, 124, 125, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  describe 'es ist zwei nach mitternacht' do
    it_behaves_like_a_word_clock(
      0,
      2,
      [0, 1, 3, 4, 5, 58, 59, 60, 61, 122, 123, 124, 125, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  describe 'es ist drei nach mitternacht' do
    it_behaves_like_a_word_clock(
      0,
      3,
      [0, 1, 3, 4, 5, 18, 19, 20, 21, 122, 123, 124, 125, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  describe 'es ist vier nach mitternacht' do
    it_behaves_like_a_word_clock(
      0,
      4,
      [0, 1, 3, 4, 5, 7, 8, 9, 10, 122, 123, 124, 125, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  describe 'es ist fünf nach mitternacht' do
    it_behaves_like_a_word_clock(
      0,
      5,
      [0, 1, 3, 4, 5, 38, 39, 40, 41, 122, 123, 124, 125, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  describe 'es ist null uhr sechs' do
    it_behaves_like_a_word_clock(
      0,
      6,
      [0, 1, 3, 4, 5, 54, 55, 56, 57, 105, 106, 107, 166, 167, 168, 169, 170]
    )
  end

  describe 'es ist null uhr sieben' do
    it_behaves_like_a_word_clock(
      0,
      7,
      [0, 1, 3, 4, 5, 54, 55, 56, 57, 105, 106, 107, 144, 145, 146, 147, 148, 149]
    )
  end

  describe 'es ist null uhr acht' do
    it_behaves_like_a_word_clock(
      0,
      8,
      [0, 1, 3, 4, 5, 54, 55, 56, 57, 105, 106, 107, 172, 173, 174, 175]
    )
  end

  describe 'es ist null uhr neun' do
    it_behaves_like_a_word_clock(
      0,
      9,
      [0, 1, 3, 4, 5, 54, 55, 56, 57, 105, 106, 107, 149, 150, 151, 152]
    )
  end

  describe 'es ist zehn nach mitternacht' do
    it_behaves_like_a_word_clock(
      0,
      10,
      [0, 1, 3, 4, 5, 68, 69, 70, 71, 122, 123, 124, 125, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  # 00:11..00:13

  describe 'es ist null uhr vier zehn' do
    it_behaves_like_a_word_clock(
      0,
      14,
      [0, 1, 3, 4, 5, 54, 55, 56, 57, 105, 106, 107, 133, 134, 135, 136, 194, 195, 196, 197]
    )
  end

  describe 'es ist viertel eins' do
    it_behaves_like_a_word_clock(
      0,
      15,
      [0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]
    )
  end

  describe 'es ist null uhr sech zehn' do
    it_behaves_like_a_word_clock(
      0,
      16,
      [0, 1, 3, 4, 5, 54, 55, 56, 57, 105, 106, 107, 166, 167, 168, 169, 194, 195, 196, 197]
    )
  end

  # 00:17..00:19

  describe 'es ist zehn vor halb eins' do
    it_behaves_like_a_word_clock(
      0,
      20,
      [0, 1, 3, 4, 5, 68, 69, 70, 71, 116, 117, 118, 140, 141, 142, 143, 182, 183, 184, 185]
    )
  end

  # 00:21..00:24

  describe 'es ist fünf vor halb eins' do
    it_behaves_like_a_word_clock(
      0,
      25,
      [0, 1, 3, 4, 5, 38, 39, 40, 41, 116, 117, 118, 140, 141, 142, 143, 182, 183, 184, 185]
    )
  end

  # 00:26..00:28

  describe 'es ist null uhr neun und zwanzig' do
    it_behaves_like_a_word_clock(
      0,
      29,
      [0, 1, 3, 4, 5, 54, 55, 56, 57, 105, 106, 107, 149, 150, 151, 152, 186, 187, 188, 198, 199, 200, 201, 202, 203, 204]
    )
  end

  describe 'es ist halb eins' do
    it_behaves_like_a_word_clock(
      0,
      30,
      [0, 1, 3, 4, 5, 140, 141, 142, 143, 182, 183, 184, 185]
    )
  end

  describe 'es ist null uhr ein und dreissig' do
    it_behaves_like_a_word_clock(
      0,
      31,
      [0, 1, 3, 4, 5, 54, 55, 56, 57, 105, 106, 107, 126, 127, 128, 186, 187, 188, 208, 209, 210, 211, 212, 213, 214, 215]
    )
  end

  # 00:32..00:34

  describe 'es ist fünf nach halb eins' do
    it_behaves_like_a_word_clock(
      0,
      35,
      [0, 1, 3, 4, 5, 38, 39, 40, 41, 122, 123, 124, 125, 140, 141, 142, 143, 182, 183, 184, 185]
    )
  end

  # 00:36..00:39

  describe 'es ist zehn nach halb eins' do
    it_behaves_like_a_word_clock(
      0,
      40,
      [0, 1, 3, 4, 5, 68, 69, 70, 71, 122, 123, 124, 125, 140, 141, 142, 143, 182, 183, 184, 185]
    )
  end

  # 00:41..00:43

  describe 'es ist null uhr vier und vierzig' do
    it_behaves_like_a_word_clock(
      0,
      44,
      [0, 1, 3, 4, 5, 54, 55, 56, 57, 105, 106, 107, 133, 134, 135, 136, 186, 187, 188, 216, 217, 218, 219, 220, 221, 222]
    )
  end

  describe 'es ist drei viertel eins' do
    it_behaves_like_a_word_clock(
      0,
      45,
      [0, 1, 3, 4, 5, 18, 19, 20, 21, 133, 134, 135, 136, 137, 138, 139, 182, 183, 184, 185]
    )
  end

  describe 'es ist null uhr sechs und vierzig' do
    it_behaves_like_a_word_clock(
      0,
      46,
      [0, 1, 3, 4, 5, 54, 55, 56, 57, 105, 106, 107, 166, 167, 168, 169, 170, 186, 187, 188, 216, 217, 218, 219, 220, 221, 222]
    )
  end

  # 00:47..00:49

  describe 'es ist zehn vor eins' do
    it_behaves_like_a_word_clock(
      0,
      50,
      [0, 1, 3, 4, 5, 68, 69, 70, 71, 116, 117, 118, 182, 183, 184, 185]
    )
  end

  # 00:51..00:53

  describe 'es ist null uhr vier und fünfzig' do
    it_behaves_like_a_word_clock(
      0,
      54,
      [0, 1, 3, 4, 5, 54, 55, 56, 57, 105, 106, 107, 133, 134, 135, 136, 186, 187, 188, 227, 228, 229, 230, 231, 232, 233]
    )
  end

  describe 'es ist fünf vor eins' do
    it_behaves_like_a_word_clock(
      0,
      55,
      [0, 1, 3, 4, 5, 38, 39, 40, 41, 116, 117, 118, 182, 183, 184, 185]
    )
  end

  describe 'es ist vier vor eins' do
    it_behaves_like_a_word_clock(
      0,
      56,
      [0, 1, 3, 4, 5, 7, 8, 9, 10, 116, 117, 118, 182, 183, 184, 185]
    )
  end

  describe 'es ist drei vor eins' do
    it_behaves_like_a_word_clock(
      0,
      57,
      [0, 1, 3, 4, 5, 18, 19, 20, 21, 116, 117, 118, 182, 183, 184, 185]
    )
  end

  describe 'es ist zwei vor eins' do
    it_behaves_like_a_word_clock(
      0,
      58,
      [0, 1, 3, 4, 5, 58, 59, 60, 61, 116, 117, 118, 182, 183, 184, 185]
    )
  end

  describe 'es ist eins vor eins' do
    it_behaves_like_a_word_clock(
      0,
      59,
      [0, 1, 3, 4, 5, 14, 15, 16, 17, 116, 117, 118, 182, 183, 184, 185]
    )
  end
end
