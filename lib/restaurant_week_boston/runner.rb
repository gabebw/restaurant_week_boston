require 'optparse'
require 'restaurant_week_boston/scraper'
require 'restaurant_week_boston/marker'

module RestaurantWeekBoston
  # Used in the executable script, +restaurant_week_boston+.
  class Runner
    # Pass in ARGV.
    def initialize(argv)
      options = {}
      optparse = OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} [options] restaurant1, restaurant2, ..."

        options[:meal] = :any
        opts.on('-m', '--meal MEAL', 'Only get restaurants that offer this meal (lunch/dinner/both/any)') do |m|
          options[:meal] = m
        end

        opts.on('-l', '--lunch RESTO1,RESTO2', 'Mark RESTAURANTS as good for lunch') do |lunches|
          options[:lunch] = lunches.split(',')
        end

        opts.on('-d', '--dinner RESTO1,RESTO2', 'Mark RESTAURANTS as good for dinner') do |dinners|
          options[:dinner] = dinners.split(',')
        end

        opts.on('-a', '--any RESTO1,RESTO2', 'Mark RESTAURANTS as good for any meal') do |any|
          options[:any] = any.split(',')
        end

        options[:neighborhood] = :all # NOT any!
        opts.on('-n', '--neighborhood HOOD',
                'Only get restaurants in this neighborhood (dorchester, back-bay, etc)') do |n|
          n = :all if n == 'any' # :any makes it choke
          options[:neighborhood] = n
        end

        opts.on('-h', '--help', 'Display this help') do
          puts opts
          return
        end
      end
      optparse.parse!(argv)
      @options = options
    end

    def run
      scraper = Scraper.new(:meal => @options[:meal],
                            :neighborhood => @options[:neighborhood])
      marker = Marker.new(scraper, @options)

      puts marker.all
    end
  end
end
