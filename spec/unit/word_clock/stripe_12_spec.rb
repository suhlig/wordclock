# frozen_string_literal: true
require 'spec_helper'
require 'word_clock/stripe'
require 'shared_examples_for_word_clock'

RSpec.describe WordClock::Stripe do
  # 12:00..12:44

  describe 'es ist zwölf uhr fünfundvierzig' do
    it_behaves_like_a_word_clock(
      12,
      45,
      [0, 1, 3, 4, 5, 63, 64, 65, 66, 67, 105, 106, 107, 162, 163, 164, 165, 186, 187, 188, 216, 217, 218, 219, 220, 221, 222]
    )
  end

  # 12:46..12:49

  describe 'es ist zwölf uhr fünfzig' do
    it_behaves_like_a_word_clock(
      12,
      50,
      [0, 1, 3, 4, 5, 63, 64, 65, 66, 67, 105, 106, 107, 227, 228, 229, 230, 231, 232, 233]
    )
  end

  # 12:51..12:54

  describe 'es ist zwölf uhr fünfundfünfzig' do
    it_behaves_like_a_word_clock(
      12,
      55,
      [0, 1, 3, 4, 5, 63, 64, 65, 66, 67, 105, 106, 107, 162, 163, 164, 165, 186, 187, 188, 227, 228, 229, 230, 231, 232, 233]
    )
  end

  # 12:56..12:59
end
