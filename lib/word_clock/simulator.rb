module WordClock
  class Simulator
    def initialize(stripe)
      @stripe = stripe
    end

    def show(pixels)
      puts "#{WordClock::reverse(pixels)} => #{pixels}"
    end
  end
end
