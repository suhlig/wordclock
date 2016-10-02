RSpec.shared_examples 'a word clock' do |hour, minute, phrase_length, expected_pixels|
  let(:pixels) { subject.pixels(hour, minute) }

  it 'has the right amount of pixels lit' do
    expect(pixels.size).to eq(phrase_length)
  end

  it 'has indices that are only increasing' do
    pixels.each_cons(2) do |prev, this|
      expect(this).to be > prev
    end
  end

  it 'has the right pixels lit' do
    expect(pixels).to eq(expected_pixels)
  end
end

def it_behaves_like_a_word_clock(*args)
  it_behaves_like('a word clock', *args)
end
