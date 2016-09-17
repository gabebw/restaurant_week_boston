require 'nokogiri'
require 'open-uri'

require 'restaurant_week_boston/restaurant'

module RestaurantWeekBoston
  # Scrapes Restaurant Week site.
  class Scraper
    include Enumerable

    URL = "http://www.restaurantweekboston.com/?neighborhood=all&meal=all&view=all&cuisine=all"

    def initialize
      @cache = File.expand_path('~/.restaurant_week_boston.cache')
      entries = doc().css('.restaurantEntry')
      @restaurants = entries.map { |entry| Restaurant.new(entry) }
    end

    # Iterates over @restaurants. All methods in Enumerable work.
    def each(&blk)
      @restaurants.each(&blk)
    end

    # Returns the result of open()ing the url from create_url(), as a String.
    def get_html
      print "Getting doc..."
      if File.size?(@cache)
        html = File.read(@cache)
      else
        html = open(URL).read
        IO.write(@cache, html)
      end
      puts "done."
      html
    end

    # Return a Nokogiri::HTML::Document parsed from get_html. Prints status
    # messages along the way.
    def doc
      # get_html beforehand for good output messages
      html = get_html
      print "Parsing doc..."
      doc = Nokogiri::HTML(html)
      puts "done."
      puts
      doc
    end

    # Pass in an array of names that =~ (case-insensitive) the ones you're
    # thinking of, and this will get those. So, if you're thinking of Bond,
    # 224 Boston Street, and Artu, you can pass in ['bond', 'boston street',
    # 'artu'].
    def special_find(names)
      results = @restaurants.find_all do |restaurant|
        names.detect { |name| name.casecmp(restaurant.name) == 0 }
      end
      # Add separators
      results.join("\n" + ("-" * 80) + "\n")
    end
  end
end
