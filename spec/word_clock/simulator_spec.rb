# frozen_string_literal: true
require 'spec_helper'
require 'word_clock/simulator'

RSpec.describe WordClock::Simulator do
  context 'with no pixels' do
    let(:pixels){[]}

    it 'has the right total amount of lines' do
      result = subject.show(pixels)
      expect(result.size).to eq(16)
    end

    it 'has the right total amount of characters' do
      result = subject.show(pixels)
      expect(result.join.size).to eq(288)
    end

    it 'is blank' do
      expect(subject.show(pixels)).to eq([
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
      ])
    end
  end

  context 'with some pixels' do
    let(:pixels){[0, 1, 3, 4, 5]}

    it 'has the right total amount of lines' do
      result = subject.show(pixels)
      expect(result.size).to eq(16)
    end

    it 'has the right total amount of characters' do
      result = subject.show(pixels)
      expect(result.join.size).to eq(288)
    end

    it 'shows the words' do
      expect(subject.show(pixels)).to eq([
        'ES IST            ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
        '                  ',
      ])
    end
  end
end
