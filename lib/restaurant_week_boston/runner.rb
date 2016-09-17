require 'optparse'
require 'restaurant_week_boston/scraper'
require 'restaurant_week_boston/marker'

module RestaurantWeekBoston
  # Used in the executable script, +restaurant_week_boston+.
  class Runner
    def initialize(argv)
      @argv = argv
      @options = {
        :meal => :all,
        :neighborhood => :all,
      }
    end

    def run
      parse_options
      scraper = Scraper.new
      marker = Marker.new(scraper, marker_options)
      puts marker.all
    end

    private

    def marker_options
      {
        :any => @options[:any],
        :dinner => @options[:dinner],
        :lunch => @options[:lunch],
      }
    end

    def parse_options
      option_parser.parse!(@argv)
    end

    def option_parser
      OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} [-l r1,... | -d r1,... | -a r1,... ]"

        opts.on('-l', '--lunch RESTO1,RESTO2', 'Mark restaurants as good for lunch') do |lunches|
          @options[:lunch] = lunches.split(',')
        end

        opts.on('-d', '--dinner RESTO1,RESTO2', 'Mark restaurants as good for dinner') do |dinners|
          @options[:dinner] = dinners.split(',')
        end

        opts.on('-a', '--any RESTO1,RESTO2', 'Mark restaurants as good for either lunch or dinner') do |any|
          @options[:any] = any.split(',')
        end

        opts.on('-h', '--help', 'Display this help') do
          puts opts
          exit 0
        end
      end
    end
  end
end
