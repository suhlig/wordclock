# frozen_string_literal: true

require 'spec_helper'
require 'word_clock/delta_calculator'

# rubocop:disable Metrics/BlockLength
RSpec.describe WordClock::DeltaCalculator do
  subject { WordClock::DeltaCalculator.new(luminance, delta) }

  context 'given a large luminance' do
    let(:luminance) { 0.9 }

    context 'and a small delta' do
      let(:delta) { 0.2 }

      it 'calculates the correct range' do
        expect(subject.to_range).to eq(0.8..1.0)
      end
    end
  end

  context 'given a null luminance' do
    let(:luminance) { 0 }

    context 'and a small delta' do
      let(:delta) { 0.2 }

      it 'calculates a positive range' do
        expect(subject.to_range).to eq(0..0.1)
      end
    end
  end

  context 'given a tiny luminance' do
    let(:luminance) { 0.1 }

    context 'and a huge delta' do
      let(:delta) { 2 }

      it 'calculates a positive range' do
        expect(subject.to_range).to eq(0..1.1)
      end
    end

    context 'and a null delta' do
      let(:delta) { 0 }

      it 'calculates a range with no space' do
        expect(subject.to_range).to eq(0.1..0.1)
      end
    end
  end
end
