require 'nokogiri'
require 'open-uri'

require 'restaurant_week_boston/restaurant'

module RestaurantWeekBoston
  # Scrapes Restaurant Week site.
  class Scraper
    include Enumerable
    # +opts+ is a hash of options, with the following keys:
    # :neighborhood:: dorchester, back-bay, etc. (default: "all")
    # :meal:: lunch, dinner, both, or any (default: "any").  Will create a
    # file in your home directory called ".restaurant_week_boston.cache"
    # which contains the HTML from the RWB site, just so it doesn't have to
    # keep getting it. You can delete that file, it'll just take longer next
    # time since it will have to re-get the HTML.
    def initialize(opts = {})
      @url = create_url(opts)
      @dump = File.expand_path('~/.restaurant_week_boston.cache')
      entries = doc().css('.restaurantEntry')
      @restaurants = entries.map{ |entry| Restaurant.new(entry) }
    end

    # +opts+ is a hash of options, with the following keys:
    # :neighborhood:: dorchester, back-bay, etc. (default: :all)
    # :meal:: lunch, dinner, both, or any (default: :any)
    def create_url(opts = {})
      # meal: any/lunch/dinner/both
      # &view=all
      default_opts = {:neighborhood => :all,
                      :meal => :any }
      opts = default_opts.merge!(opts)
      sprintf('http://www.restaurantweekboston.com/?neighborhood=%s&meal=%s&view=all',
              opts[:neighborhood].to_s, opts[:meal].to_s)
    end


    # Iterates over @restaurants. All methods in Enumerable work.
    def each(&blk)
      @restaurants.each(&blk)
    end

    # Returns the result of open()ing the url from create_url(), as a String.
    def get_html
      print "Getting doc..."
      if File.size? @dump
        html = File.read(@dump)
      else
        html = open(@url).read()
        f = File.new(@dump, 'w')
        f.write(html)
        f.close()
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
    def special_find(array)
      array.map! do |name|
        /#{Regexp.escape(name)}/i
      end
      results = @restaurants.find_all do |restaurant|
        array.detect{ |regexp| regexp =~ restaurant.name }
      end
      # Add separators
      results.join("\n" + '-' * 80 + "\n")
    end
  end
end
