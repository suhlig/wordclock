# frozen_string_literal: true
module WordClock
  module Terminal
    class Client
      def initialize(io, column_count, row_count)
        @io = io
        @column_count = column_count
        @row_count = row_count
      end

      def write(strip)
        header

        strip.pixels.each_slice(@column_count) do |row|
          line(row)
        end

        footer
      end

      def line(payload)
        p_line('| ', payload.join(' '), ' |')
      end

      def header
        payload = ('-' * @column_count).chars
        p_line('+-', payload.join('-'), '-+')
      end

      alias_method :footer, :header

      def p_line(left, middle, right)
        @io.puts [left, middle, right].join
      end
    end
  end
end
