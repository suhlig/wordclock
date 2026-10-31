# frozen_string_literal: true

require 'word_clock/color'
require 'word_clock/terminal/pixel'

describe WordClock::Terminal::Pixel do
  subject(:pixel) { described_class.new('X') }

  let(:off_color) { Rainbow('X').color(43, 43, 43) }

  it 'renders an unset pixel as dark grey' do
    expect(pixel.to_s).to eq(off_color)
  end

  it 'renders a black pixel as dark grey' do
    pixel.set(r: 0, g: 0, b: 0)

    expect(pixel.to_s).to eq(off_color)
  end

  it 'renders a pixel with its own color' do
    pixel.set(r: 1, g: 2, b: 3)

    expect(pixel.to_s).to eq(Rainbow('X').color(1, 2, 3))
  end

  it 'accepts the keyword arguments produced by Color#to_h' do
    pixel.set(**WordClock::Color.new(1, 2, 3).to_h)

    expect(pixel.to_s).to eq(Rainbow('X').color(1, 2, 3))
  end
end
