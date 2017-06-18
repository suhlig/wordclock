# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples_for_word_clock'

RSpec.describe WordClock::Clock24 do
  # 2:00..02:04

  describe 'es ist fünf nach zwei' do
    it_behaves_like_a_word_clock(
      2,
      5,
      [0, 1, 3, 4, 5, 38, 39, 40, 41, 122, 123, 124, 125, 156, 157, 158, 159]
    )
  end

  # 2:06..02:09

  describe 'es ist zehn nach zwei' do
    it_behaves_like_a_word_clock(
      2,
      10,
      [0, 1, 3, 4, 5, 68, 69, 70, 71, 122, 123, 124, 125, 156, 157, 158, 159]
    )
  end

  # 2:11..02:59
end
