# frozen_string_literal: true
RSpec.shared_examples 'a word clock' do |description, hour, minute, expected_pixels|
  let(:pixels) { subject.pixels(hour, minute) }

  it 'has the right amount of pixels lit' do
    expect(pixels.size).to eq(phrase_length(description))
  end

  it 'has indices that are only increasing' do
    pixels.each_cons(2) do |prev, this|
      expect(this).to be > prev
    end
  end

  it 'has the right pixels lit' do
    expect(pixels).to eq(expected_pixels), "Expected #{expected_pixels}, but got #{pixels} => '#{subject.reverse(pixels)}'"
  end
end
