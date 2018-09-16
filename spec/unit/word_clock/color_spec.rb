# frozen_string_literal: true

require 'word_clock/color'

# rubocop:disable Metrics/BlockLength
RSpec.shared_examples 'similar luminance' do |r, g, b|
  subject { WordClock::Color.new(r, g, b) }

  it 'has the expected luminance' do
    expect(subject.relative_luminance).to be_within(0.1).of(luminance)
  end
end

describe WordClock::Color do
  context 'with luminance ~1' do
    let(:luminance) { 1 }
    it_behaves_like('similar luminance', 255, 255, 255)
  end

  context 'with luminance ~0' do
    let(:luminance) { 0 }
    it_behaves_like('similar luminance', 0, 0, 0)
  end

  # the following examples from https://en.wikipedia.org/wiki/Luma_(video)
  context 'NTSC (1953) primaries' do
    context 'with luminance ~0.53' do
      let(:luminance) { 0.73 }

      it_behaves_like('similar luminance', 255, 147, 255)
      it_behaves_like('similar luminance', 255, 170, 170)
      it_behaves_like('similar luminance', 211, 211, 0)
      it_behaves_like('similar luminance', 192, 192, 255)
      it_behaves_like('similar luminance', 200, 200, 200)
      it_behaves_like('similar luminance', 122, 244, 0)
      it_behaves_like('similar luminance', 0, 235, 235)
      it_behaves_like('similar luminance', 0, 250, 125)
      it_behaves_like('similar luminance', 0, 255, 0)
    end
  end

  context 'BT.709 primaries' do
    context 'with luminance ~0.85' do
      let(:luminance) { 0.85 }

      it_behaves_like('similar luminance', 255, 203, 255)
      it_behaves_like('similar luminance', 255, 208, 208)
      it_behaves_like('similar luminance', 227, 227, 0)
      it_behaves_like('similar luminance', 216, 216, 255)
      it_behaves_like('similar luminance', 219, 219, 219)
      it_behaves_like('similar luminance', 124, 248, 0)
      it_behaves_like('similar luminance', 0, 244, 244)
    end

    context 'with luminance ~0.15' do
      let(:luminance) { 0.15 }

      it_behaves_like('similar luminance', 158, 0, 79)
      it_behaves_like('similar luminance', 142, 0, 142)
      it_behaves_like('similar luminance', 104, 0, 208)
      it_behaves_like('similar luminance', 0, 0, 255)
    end
  end
end
# rubocop:enable Metrics/BlockLength
