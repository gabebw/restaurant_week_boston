require 'restaurant_week_boston/scraper'

module RestaurantWeekBoston
  # Uses a given Scraper and marks restaurants as good for lunch, dinner, any,
  # etc.
  class Marker
    # +opts+ is a hash with keys for +:lunch+, +:dinner+, and +:any+.
    # The values of each of these keys should be an array suitable for passing
    # to Scraper#special_find().
    def initialize(scraper, opts)
      @scraper = scraper
      @opts = opts
    end

    # Print out restaurants that are good for lunch.
    def lunch
      unless @lunch
        if @opts.key?(:lunch)
          @lunch = @scraper.special_find(@opts[:lunch])
        else
          @lunch = '[no lunch options specified]'
        end
      end
      puts "=== LUNCH ==="
      puts @lunch
    end

    # Print out restaurants that are good for dinner.
    def dinner
      unless @dinner
        if @opts.key?(:dinner)
          @dinner = @scraper.special_find(@opts[:dinner])
        else
          @dinner = '[no dinner options specified]'
        end
      end
      puts "=== DINNER ==="
      puts @dinner
    end

    # Print out restaurants that are good for lunch or dinner.
    def any
      unless @any
        if @opts.key?(:any)
          @any = @scraper.special_find(@opts[:any])
        else
          @any = '[no "lunch or dinner" options specified]'
        end
      end
      puts "=== LUNCH OR DINNER ==="
      puts @any
    end

    # Print lunch(), dinner(), and any(), with newlines between them.
    def all
      lunch()
      puts
      dinner()
      puts
      any()
    end
  end
end
