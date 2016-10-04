# frozen_string_literal: true

module WordClock
  class Border
    attr_reader :top, :bottom, :left, :right

    def initialize(top:, bottom:, left:, right:)
      @top = top
      @bottom = bottom
      @left = left
      @right = right
    end

    NULL = Border.new(top: '', bottom: '', left: '', right: '')
    FRAME = Border.new(top: '-', bottom: '-', left: '| ', right: ' |')

    def frame(lines)
      border_width = 18 + left.to_s.length + right.to_s.length

      lines.map do |line|
        line.prepend(left.to_s).concat(right.to_s)
      end.tap do |framed|
        framed.unshift(top.to_s * border_width) # add header row
        framed.push(bottom.to_s * border_width) # add footer row
      end
    end
  end
end
