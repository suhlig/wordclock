# frozen_string_literal: true

require 'spec_helper'
require 'word_clock/xkcd_color_sampler'
RSpec.describe WordClock::XkcdColorSampler do
  subject(:colors) { WordClock::XkcdColorSampler.new }

  it "returns the color 'acidgreen'" do
    expect(Kernel).to receive(:rand).and_return(0)
    sampled = colors.sample
    expect(sampled).to be

    expect(sampled.red).to eq('8F'.to_i(16))
    expect(sampled.green).to eq('FE'.to_i(16))
    expect(sampled.blue).to eq('09'.to_i(16))

    expect(sampled.name).to  eq('acidgreen')
    expect(sampled.to_s).to  eq('[143,254,9] (acidgreen)')
  end

  it "returns the color 'barneypurple'" do
    expect(Kernel).to receive(:rand).and_return(37)
    sampled = colors.sample
    expect(sampled).to be

    expect(sampled.red).to   eq('A0'.to_i(16))
    expect(sampled.green).to eq('04'.to_i(16))
    expect(sampled.blue).to  eq('98'.to_i(16))

    expect(sampled.name).to  eq('barneypurple')
    expect(sampled.to_s).to  eq('[160,4,152] (barneypurple)')
  end
end
