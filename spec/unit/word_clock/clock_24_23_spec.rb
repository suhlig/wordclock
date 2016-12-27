# frozen_string_literal: true
require 'spec_helper'
require 'shared_examples_for_word_clock'

RSpec.describe WordClock::Clock24 do
  # 23:00..23:53

  describe 'es ist drei und zwanzig uhr vier und fünfzig' do
    it_behaves_like_a_word_clock(
      23,
      54,
      [0, 1, 3, 4, 5, 18, 19, 20, 21, 72, 73, 74, 76, 77, 78, 79, 80, 81, 82, 105, 106, 107, 133, 134, 135, 136, 186, 187, 188, 227, 228, 229, 230, 231, 232, 233]
    )
  end

  describe 'es ist fünf vor mitternacht' do
    it_behaves_like_a_word_clock(
      23,
      55,
      [0, 1, 3, 4, 5, 38, 39, 40, 41, 116, 117, 118, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  describe 'es ist vier vor mitternacht' do
    it_behaves_like_a_word_clock(
      23,
      56,
      [0, 1, 3, 4, 5, 7, 8, 9, 10, 116, 117, 118, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  describe 'es ist drei vor mitternacht' do
    it_behaves_like_a_word_clock(
      23,
      57,
      [0, 1, 3, 4, 5, 18, 19, 20, 21, 116, 117, 118, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  describe 'es ist zwei vor mitternacht' do
    it_behaves_like_a_word_clock(
      23,
      58,
      [0, 1, 3, 4, 5, 58, 59, 60, 61, 116, 117, 118, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end

  describe 'es ist eins vor mitternacht' do
    it_behaves_like_a_word_clock(
      23,
      59,
      [0, 1, 3, 4, 5, 14, 15, 16, 17, 116, 117, 118, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268]
    )
  end
end
