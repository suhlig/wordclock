# frozen_string_literal: true

require 'spec_helper'
require 'word_clock/minumum_luminance_sampler'

RSpec.describe WordClock::MinumumLuminanceSampler do
  subject { WordClock::MinumumLuminanceSampler.new(Range.new(min, max)) }
  let(:min) { 0 }
  let(:max) { 255 }

  context 'luminance greater than zero' do
    let(:min) { 50 }

    it 'has the given minimal luminance' do
      # do not give in at the first attempt
      expect(Kernel).to receive(:rand).and_return(0)
      expect(Kernel).to receive(:rand).and_return(0)
      expect(Kernel).to receive(:rand).and_return(0)

      expect(Kernel).to receive(:rand).and_return(255)
      expect(Kernel).to receive(:rand).and_return(255)
      expect(Kernel).to receive(:rand).and_return(255)

      expect(subject.sample.luminance).to be >= 100
    end
  end
end
