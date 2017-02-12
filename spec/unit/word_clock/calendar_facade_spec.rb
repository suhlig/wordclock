# frozen_string_literal: true
require 'spec_helper'
require 'word_clock/calendar_facade'

RSpec.describe WordClock::CalendarFacade do
  subject(:sampler) { WordClock::CalendarFacade.new(delegate) }
  let(:delegate) { instance_double('XkcdColors') }

  context 'on a regular day' do
    let(:time) { Time.parse('1.11.2017 14:32') }

    describe 'on first sample' do
      it 'returns the a color sampled from the delegate' do
        expect(delegate).to receive(:sample).and_return('blue')
        expect(sampler.sample(time)).to eq('blue')
      end
    end

    describe 'on subsequent samples' do
      it 'returns the a color sampled from the delegate' do
        expect(delegate).to receive(:sample).and_return('blue')

        42.times do
          expect(sampler.sample(time)).to eq('blue')
        end
      end
    end
  end

  context 'right before start of carnival' do
    let(:time) { Time.parse('11.11.2017 11:10') }

    it 'returns the a color sampled from the delegate' do
      expect(delegate).to receive(:sample).and_return('blue')

      42.times do
        expect(sampler.sample(time)).to eq('blue')
      end
    end
  end

  context 'at 11.11. after 11:11' do
    let(:time) { Time.parse('11.11.2017 11:11:23') }

    it 'retrieves a new color from the delegate with every sample' do
      expect(delegate).to receive(:sample).and_return('red')
      expect(delegate).to receive(:sample).and_return('green')
      expect(delegate).to receive(:sample).and_return('blue')

      expect(sampler.sample(time)).to eq('red')
      expect(sampler.sample(time)).to eq('green')
      expect(sampler.sample(time)).to eq('blue')
    end
  end

  context 'at Rosenmontag 2017' do
    let(:time) { Time.parse('27.2.2017') }

    it 'retrieves a new color from the delegate with every sample' do
      expect(delegate).to receive(:sample).and_return('red')
      expect(delegate).to receive(:sample).and_return('green')
      expect(delegate).to receive(:sample).and_return('blue')

      expect(sampler.sample(time)).to eq('red')
      expect(sampler.sample(time)).to eq('green')
      expect(sampler.sample(time)).to eq('blue')
    end
  end

  context 'at Faschingsdienstag 2017' do
    let(:time) { Time.parse('28.2.2017') }

    it 'retrieves a new color from the delegate with every sample' do
      expect(delegate).to receive(:sample).and_return('red')
      expect(delegate).to receive(:sample).and_return('green')
      expect(delegate).to receive(:sample).and_return('blue')

      expect(sampler.sample(time)).to eq('red')
      expect(sampler.sample(time)).to eq('green')
      expect(sampler.sample(time)).to eq('blue')
    end
  end

  context 'at Aschermittwoch 2017' do
    let(:time) { Time.parse('1.3.2017') }

    it 'ignores the delegate and returns grey all day' do
      expect(delegate).to_not receive(:sample)

      42.times do
        expect(sampler.sample(time)).to eq('grey')
      end
    end
  end

  context 'at my 50th birthday' do
    let(:time) { Time.parse('8.4.2020 10:15:42') }

    it 'retrieves a new color from the delegate with every sample' do
      expect(delegate).to receive(:sample).and_return('blue')
      expect(delegate).to receive(:sample).and_return('green')
      expect(delegate).to receive(:sample).and_return('red')

      expect(sampler.sample(time)).to eq('blue')
      expect(sampler.sample(time)).to eq('green')
      expect(sampler.sample(time)).to eq('red')
    end
  end
end
