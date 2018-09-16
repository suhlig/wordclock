# frozen_string_literal: true

require 'word_clock/xkcd_color_sampler'
require 'word_clock/luminance_range_sampler'

describe 'XkcdColorSampler with limited luminance range' do
  subject(:color) { WordClock::LuminanceRangeSampler.new(WordClock::XkcdColorSampler.new, luminance_range).sample }

  context 'visible at all' do
    let(:luminance_range) { 0.1..1 }

    it 'has a luminance over 0.1' do
      allow(Kernel).to receive(:rand).and_return(42) # black must fail
      allow(Kernel).to receive(:rand).and_return(21) # azure must succeed

      expect(color.relative_luminance).to be_within(0.01).of(0.5)
      expect(color.name).to eq('azure')
    end
  end

  context 'pretty bright' do
    let(:luminance_range) { 0.8..1 }

    it 'has a luminance over 0.8' do
      allow(Kernel).to receive(:rand).and_return(21) # azure must fail
      allow(Kernel).to receive(:rand).and_return(32) # banana must succeed

      expect(color.relative_luminance).to be_within(0.2).of(0.9)
      expect(color.name).to eq('banana')
    end
  end
end
