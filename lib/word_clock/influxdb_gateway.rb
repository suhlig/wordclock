# frozen_string_literal: true

require 'influxdb'

module WordClock
  class InfluxDbGateway
    def initialize(*args)
      @influxdb = InfluxDB::Client.new(*args)
    end

    def current_illuminance
      @influxdb.query('select median(value) from light WHERE time > now() - 60s;').first['values'].first['median']
    end

    def illuminance_percentile(nth)
      @influxdb.query("select percentile(value, #{nth}) from light").first['values'].first['percentile']
    end
  end
end
