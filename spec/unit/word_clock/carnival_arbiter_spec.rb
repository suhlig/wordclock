# frozen_string_literal: true

require 'spec_helper'
require 'word_clock/carnival_arbiter'

# rubocop:disable Metrics/BlockLength
RSpec.describe WordClock::CarnivalArbiter do
  subject(:arbiter) { WordClock::CarnivalArbiter.new }

  context 'around 11.11.' do
    it 'does not match right before 11.11. 11:11' do
      expect(arbiter.match?(Time.parse('11.11.2017 11:10:59'))).to be_falsey
    end

    it 'matches right at 11.11. 11:11' do
      expect(arbiter.match?(Time.parse('11.11.2017 11:11:00'))).to be_truthy
    end

    it 'matches after 11.11. 17:34' do
      expect(arbiter.match?(Time.parse('11.11.2017 17:34'))).to be_truthy
    end

    it 'matches right before midnight' do
      expect(arbiter.match?(Time.parse('11.11.2017 23:59:59'))).to be_truthy
    end

    it 'does not match right at midnight' do
      expect(arbiter.match?(Time.parse('12.11.2017 00:00:00'))).to be_falsey
    end
  end

  context 'around Rosenmontag' do
    it 'does not match right before Rosenmontag' do
      expect(arbiter.match?(Time.parse('26.2.2017 23:59:59'))).to be_falsey
    end

    it 'matches right at the beginning of Rosenmontag' do
      expect(arbiter.match?(Time.parse('27.2.2017 00:00:00'))).to be_truthy
    end

    it 'matches during Rosenmontag' do
      expect(arbiter.match?(Time.parse('27.2.2017 12:20'))).to be_truthy
    end

    it 'matches right before the end of Rosenmontag' do
      expect(arbiter.match?(Time.parse('27.2.2017 23:59:59'))).to be_truthy
    end
  end

  it 'matches right at midnight between Rosenmontag and Faschingsdienstag' do
    expect(arbiter.match?(Time.parse('28.2.2017 00:00:00'))).to be_truthy
  end

  context 'around Faschingsdienstag' do
    it 'matches right at the beginning of Faschingsdienstag' do
      expect(arbiter.match?(Time.parse('28.2.2017 00:00:01'))).to be_truthy
    end

    it 'matches during Faschingsdienstag' do
      expect(arbiter.match?(Time.parse('28.2.2017 19:35'))).to be_truthy
    end

    it 'matches right before the end of Faschingsdienstag' do
      expect(arbiter.match?(Time.parse('28.2.2017 23:59:59'))).to be_truthy
    end

    it 'does not match right after Faschingsdienstag' do
      expect(arbiter.match?(Time.parse('1.3.2017 00:00:00'))).to be_falsey
    end
  end
end
