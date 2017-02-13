# frozen_string_literal: true
require 'spec_helper'
require 'word_clock/color_picker'

RSpec.describe WordClock::ColorPicker do
  subject(:color_picker) { WordClock::ColorPicker.new(color_sampler) }
  let(:color_sampler) { instance_double('XkcdColors') }

  context 'on a regular day' do
    let(:time) { Time.parse('1.11.2017 14:32') }

    describe 'on first sample' do
      it 'returns the a color sampled from the color_sampler' do
        expect(color_sampler).to receive(:sample).and_return('blue')
        expect(color_picker.choose(time)).to eq('blue')
      end
    end

    describe 'on subsequent samples' do
      it 'returns the a color sampled from the color_sampler' do
        expect(color_sampler).to receive(:sample).and_return('blue')

        42.times do
          expect(color_picker.choose(time)).to eq('blue')
        end
      end
    end
  end

  context 'right before start of carnival' do
    let(:time) { Time.parse('11.11.2017 11:10') }

    it 'returns the a color sampled from the color_sampler' do
      expect(color_sampler).to receive(:sample).and_return('blue')

      42.times do
        expect(color_picker.choose(time)).to eq('blue')
      end
    end
  end

  context 'at 11.11. at 11:11' do
    let(:time) { Time.parse('11.11.2017 11:11:00') }

    it 'retrieves a new color from the color_sampler with every sample' do
      expect(color_sampler).to receive(:sample).and_return('red')
      expect(color_sampler).to receive(:sample).and_return('green')
      expect(color_sampler).to receive(:sample).and_return('blue')

      expect(color_picker.choose(time)).to eq('red')
      expect(color_picker.choose(time)).to eq('green')
      expect(color_picker.choose(time)).to eq('blue')
    end
  end

  context 'at 11.11. after 11:11' do
    let(:time) { Time.parse('11.11.2017 23:59:59') }

    it 'retrieves a new color from the color_sampler with every sample' do
      expect(color_sampler).to receive(:sample).and_return('red')
      expect(color_sampler).to receive(:sample).and_return('green')
      expect(color_sampler).to receive(:sample).and_return('blue')

      expect(color_picker.choose(time)).to eq('red')
      expect(color_picker.choose(time)).to eq('green')
      expect(color_picker.choose(time)).to eq('blue')
    end
  end

  context 'at 12.11. after midnight' do
    let(:time) { Time.parse('12.11.2017 00:21') }

    describe 'on first sample' do
      it 'returns the a color sampled from the color_sampler' do
        expect(color_sampler).to receive(:sample).and_return('blue')
        expect(color_picker.choose(time)).to eq('blue')
      end
    end

    describe 'on subsequent samples' do
      it 'returns the a color sampled from the color_sampler' do
        expect(color_sampler).to receive(:sample).and_return('blue')

        42.times do
          expect(color_picker.choose(time)).to eq('blue')
        end
      end
    end
  end

  context 'at Rosenmontag 2017' do
    let(:time) { Time.parse('27.2.2017') }

    it 'retrieves a new color from the color_sampler with every sample' do
      expect(color_sampler).to receive(:sample).and_return('red')
      expect(color_sampler).to receive(:sample).and_return('green')
      expect(color_sampler).to receive(:sample).and_return('blue')

      expect(color_picker.choose(time)).to eq('red')
      expect(color_picker.choose(time)).to eq('green')
      expect(color_picker.choose(time)).to eq('blue')
    end
  end

  context 'at Faschingsdienstag 2017' do
    let(:time) { Time.parse('28.2.2017') }

    it 'retrieves a new color from the color_sampler with every sample' do
      expect(color_sampler).to receive(:sample).and_return('red')
      expect(color_sampler).to receive(:sample).and_return('green')
      expect(color_sampler).to receive(:sample).and_return('blue')

      expect(color_picker.choose(time)).to eq('red')
      expect(color_picker.choose(time)).to eq('green')
      expect(color_picker.choose(time)).to eq('blue')
    end
  end

  context 'at Aschermittwoch 2017' do
    let(:time) { Time.parse('1.3.2017') }

    it 'ignores the color_sampler and returns grey all day' do
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

  context 'at my 50th birthday' do
    let(:time) { Time.parse('8.4.2020 10:15:42') }

    it 'retrieves a new color from the color_sampler with every sample' do
      expect(color_sampler).to receive(:sample).and_return('blue')
      expect(color_sampler).to receive(:sample).and_return('green')
      expect(color_sampler).to receive(:sample).and_return('red')

      expect(color_picker.choose(time)).to eq('blue')
      expect(color_picker.choose(time)).to eq('green')
      expect(color_picker.choose(time)).to eq('red')
    end
  end
end
