# frozen_string_literal: true

require 'word_clock/color_picker'

shared_examples 'monochromatic display' do
  describe 'the first call' do
    it 'returns the first color sampled from the color_sampler' do
      expect(color_sampler).to receive(:sample).and_return('blue')
      expect(color_picker.choose(time)).to eq('blue')
    end
  end

  describe 'subsequent calls' do |variable|
    it 'return the same color' do
      expect(color_sampler).to receive(:sample).and_return('blue')

      42.times do
        expect(color_picker.choose(time)).to eq('blue')
      end
    end
  end
end

shared_examples 'polychromatic display' do
  it 'retrieves a new color from the color_sampler with every sample' do
    expect(color_sampler).to receive(:sample).and_return('red')
    expect(color_sampler).to receive(:sample).and_return('green')
    expect(color_sampler).to receive(:sample).and_return('blue')

    expect(color_picker.choose(time)).to eq('red')
    expect(color_picker.choose(time)).to eq('green')
    expect(color_picker.choose(time)).to eq('blue')
  end
end

shared_examples 'all-grey display' do
  it 'ignores the color_sampler and returns grey' do
    expect(color_sampler).to_not receive(:sample)

    23.times do
      color = color_picker.choose(time)
      expect(color).to be

      # Some shade of grey (r == g == b)
      expect(color.red).to eq(color.green)
      expect(color.green).to eq(color.blue)
    end
  end
end

# rubocop:disable Metrics/BlockLength
describe WordClock::ColorPicker do
  subject(:color_picker) { WordClock::ColorPicker.new(color_sampler) }
  let(:color_sampler) { instance_double('XkcdColorSampler') }

  context 'on a regular day' do
    let(:time) { Time.parse('1.11.2017 14:32') }
    it_behaves_like('monochromatic display')
  end

  describe 'around 11.11.' do
    context 'right before start of carnival' do
      let(:time) { Time.parse('11.11.2017 11:10') }
      it_behaves_like('monochromatic display')
    end

    context 'at 11.11. at 11:11' do
      let(:time) { Time.parse('11.11.2017 11:11:00') }
      it_behaves_like('polychromatic display')
    end

    context 'at 11.11. after 11:11' do
      let(:time) { Time.parse('11.11.2017 23:59:59') }
      it_behaves_like('polychromatic display')
    end

    context 'at 12.11. after midnight' do
      let(:time) { Time.parse('12.11.2017 00:21') }
      it_behaves_like('monochromatic display')
    end
  end

  describe 'around Fasching' do
    context 'at Rosenmontag 2017' do
      let(:time) { Time.parse('27.2.2017') }
      it_behaves_like('polychromatic display')
    end

    context 'at Faschingsdienstag 2017' do
      let(:time) { Time.parse('28.2.2017') }
      it_behaves_like('polychromatic display')
    end

    context 'at Aschermittwoch 2017' do
      let(:time) { Time.parse('1.3.2017') }
      it_behaves_like('all-grey display')
    end
  end

  context 'around Silvester' do
    describe 'right before' do
      let(:time) { Time.parse('30.12.2017 23:59:59') }
      it_behaves_like('monochromatic display')
    end

    context 'during the day' do
      let(:time) { Time.parse('31.12.2017 17:36') }
      it_behaves_like('polychromatic display')
    end

    context 'during the night' do
      let(:time) { Time.parse('1.1.2018 01:36:00') }
      it_behaves_like('polychromatic display')
    end

    context 'from 6 in the morning' do
      let(:time) { Time.parse('1.1.2018 06:00:00') }
      it_behaves_like('all-grey display')
    end

    context 'at Jan 2nd' do
      let(:time) { Time.parse('2.1.2018 00:00') }
      it_behaves_like('monochromatic display')
    end
  end

  context 'at a specific birthday' do
    let(:time) { Time.parse('8.4.2020 10:15:42') }
    it_behaves_like('polychromatic display')
  end
end
# rubocop:enable Metrics/BlockLength
