# frozen_string_literal: true
require 'spec_helper'
require 'word_clock/stripe'
require 'shared_examples_for_word_clock'

RSpec.describe WordClock::Stripe do
  describe 'es ist ein uhr' do
    it_behaves_like_a_word_clock(
      1,
      0,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107]
    )
  end

  describe 'es ist ein uhr eins' do
    it_behaves_like_a_word_clock(
      1,
      1,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 182, 183, 184, 185]
    )
  end

  describe 'es ist ein uhr zwei' do
    it_behaves_like_a_word_clock(
      1,
      2,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 156, 157, 158, 159]
    )
  end

  # 01:03..01:04

  describe 'es ist fünf nach eins' do
    it_behaves_like_a_word_clock(
      1,
      5,
      [0, 1, 3, 4, 5, 38, 39, 40, 41, 122, 123, 124, 125, 182, 183, 184, 185]
    )
  end

  describe 'es ist ein uhr sechs' do
    it_behaves_like_a_word_clock(
      1,
      6,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 166, 167, 168, 169, 170]
    )
  end

  # 01:07..01:09

  describe 'es ist zehn nach eins' do
    it_behaves_like_a_word_clock(
      1,
      10,
      [0, 1, 3, 4, 5, 68, 69, 70, 71, 122, 123, 124, 125, 182, 183, 184, 185]
    )
  end

  describe 'es ist ein uhr elf' do
    it_behaves_like_a_word_clock(
      1,
      11,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 190, 191, 192]
    )
  end

  # 01:12..01:13

  describe 'es ist ein uhr vier zehn' do
    it_behaves_like_a_word_clock(
      1,
      14,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 133, 134, 135, 136, 194, 195, 196, 197]
    )
  end

  describe 'es ist viertel zwei' do
    it_behaves_like_a_word_clock(
      1,
      15,
      [0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 58, 59, 60, 61]
    )
  end

  describe 'es ist ein uhr sech zehn' do
    it_behaves_like_a_word_clock(
      1,
      16,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 166, 167, 168, 169, 194, 195, 196, 197]
    )
  end

  # 01:07..01:18

  describe 'es ist ein uhr neun zehn' do
    it_behaves_like_a_word_clock(
      1,
      19,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 149, 150, 151, 152, 194, 195, 196, 197]
    )
  end

  describe 'es ist zehn vor halb zwei' do
    it_behaves_like_a_word_clock(
      1,
      20,
      [0, 1, 3, 4, 5, 68, 69, 70, 71, 116, 117, 118, 140, 141, 142, 143, 156, 157, 158, 159]
    )
  end

  describe 'es ist ein uhr ein und zwanzig' do
    it_behaves_like_a_word_clock(
      1,
      21,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 126, 127, 128, 186, 187, 188, 198, 199, 200, 201, 202, 203, 204]
    )
  end

  # 01:22..01:23

  describe 'es ist ein uhr vier und zwanzig' do
    it_behaves_like_a_word_clock(
      1,
      24,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 133, 134, 135, 136, 186, 187, 188, 198, 199, 200, 201, 202, 203, 204]
    )
  end

  describe 'es ist fünf vor halb zwei' do
    it_behaves_like_a_word_clock(
      1,
      25,
      [0, 1, 3, 4, 5, 38, 39, 40, 41, 116, 117, 118, 140, 141, 142, 143, 156, 157, 158, 159]
    )
  end

  describe 'es ist ein uhr sechs und zwanzig' do
    it_behaves_like_a_word_clock(
      1,
      26,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 166, 167, 168, 169, 170, 186, 187, 188, 198, 199, 200, 201, 202, 203, 204]
    )
  end

  # 01:27..01:28

  describe 'es ist ein uhr neun und zwanzig' do
    it_behaves_like_a_word_clock(
      1,
      29,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 149, 150, 151, 152, 186, 187, 188, 198, 199, 200, 201, 202, 203, 204]
    )
  end

  describe 'es ist halb zwei' do
    it_behaves_like_a_word_clock(
      1,
      30,
      [0, 1, 3, 4, 5, 140, 141, 142, 143, 156, 157, 158, 159]
    )
  end

  # 01:31..01:39

  describe 'es ist zehn nach halb zwei' do
    it_behaves_like_a_word_clock(
      1,
      40,
      [0, 1, 3, 4, 5, 68, 69, 70, 71, 122, 123, 124, 125, 140, 141, 142, 143, 156, 157, 158, 159]
    )
  end

  # 01:41..01:44

  describe 'es ist drei viertel zwei' do
    it_behaves_like_a_word_clock(
      1,
      45,
      [0, 1, 3, 4, 5, 18, 19, 20, 21, 133, 134, 135, 136, 137, 138, 139, 156, 157, 158, 159]
    )
  end

  # 01:46..01:53

  describe 'es ist ein uhr vier und fünfzig' do
    it_behaves_like_a_word_clock(
      1,
      54,
      [0, 1, 3, 4, 5, 14, 15, 16, 105, 106, 107, 133, 134, 135, 136, 186, 187, 188, 227, 228, 229, 230, 231, 232, 233]
    )
  end

  # 01:55..01:59
end
