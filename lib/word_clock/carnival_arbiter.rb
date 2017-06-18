# frozen_string_literal: true

require 'easter'

module WordClock
  class CarnivalArbiter
    def match?(time)
      eleven_eleven = Time.new(time.year, 11, 11, 11, 11)..Time.new(time.year, 11, 11, 23, 59, 59)

      return true if eleven_eleven.cover?(time)
      return true if time.to_date == Easter.easter - 48 # Rosenmontag
      return true if time.to_date == Easter.easter - 47 # Faschingsdienstag

      false
    end
  end
end
