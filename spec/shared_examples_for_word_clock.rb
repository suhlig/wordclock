# frozen_string_literal: true
require 'word_clock/clock_24'

RSpec.shared_examples 'a word clock' do |description, hour, minute, expected_pixels|
  let(:subject) { WordClock::Clock24.new(Time.parse("#{hour}:#{minute}")) }
  let(:pixels) { subject.pixels }

  it 'has the right amount of pixels lit' do
    expect(pixels.size).to eq(phrase_length(description))
  end

  it 'has indices that are only increasing' do
    pixels.each_cons(2) do |prev, this|
      expect(this).to be > prev
    end
  end

  it 'has the right pixels lit' do
    expect(pixels).to eq(expected_pixels), "Expected #{expected_pixels}, but got #{pixels} => '#{WordClock::Clock24.words(pixels)}'"
  end
end
