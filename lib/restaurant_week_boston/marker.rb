require 'restaurant_week_boston/scraper'

module RestaurantWeekBoston
  # Uses a given Scraper and marks restaurants as good for lunch, dinner, any,
  # etc.
  class Marker
    NONE_REQUESTED = '[No restaurants requested]'

    # +opts+ is a hash with keys for +:lunch+, +:dinner+, and +:any+.
    # The values of each of these keys should be an array suitable for passing
    # to Scraper#special_find().
    def initialize(scraper, opts)
      @scraper = scraper
      @opts = opts
    end

    # Print all of the requested restaurants.
    def all
      lunch
      puts
      dinner
      puts
      any
    end

    private

    # Print out restaurants that are good for lunch.
    def lunch
      puts "=== LUNCH ==="
      puts find(@opts[:lunch])
    end

    # Print out restaurants that are good for dinner.
    def dinner
      puts "=== DINNER ==="
      puts find(@opts[:dinner])
    end

    # Print out restaurants that are good for lunch or dinner.
    def any
      puts "=== LUNCH OR DINNER ==="
      puts find(@opts[:any])
    end

    def find(names)
      if names
        @scraper.special_find(names)
      else
        NONE_REQUESTED
      end
    end
  end
end
