# frozen_string_literal: true

require 'spec_helper'
require 'word_clock/color'
require 'word_clock/luminance_range_sampler'

RSpec.describe WordClock::LuminanceRangeSampler do
  subject { WordClock::LuminanceRangeSampler.new(delegate, Range.new(min, max)) }
  let(:delegate) { double }

  context 'within a range of possible luminance close to the top' do
    let(:min) { 0 }
    let(:max) { 1 }

    before do
      allow(delegate).to receive(:sample).and_return(WordClock::Color.new(255, 255, 255))
    end

    it 'luminance is as expected' do
      expect(subject.sample.relative_luminance).to be_within(0.01).of(1)
    end
  end

  context 'within a range of possible luminance close to the bottom' do
    let(:min) { 0 }
    let(:max) { 0.1 }

    before do
      allow(delegate).to receive(:sample).and_return(WordClock::Color.new(10, 10, 10))
    end

    it 'luminance is as expected' do
      expect(subject.sample.relative_luminance).to be_within(0.01).of(0.03)
    end
  end
end
