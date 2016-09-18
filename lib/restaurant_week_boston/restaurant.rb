module RestaurantWeekBoston
  # A Restaurant has the following properties:
  # * name ("224 Boston Street")
  # * short-name ("224-boston-street", used internally by RWB site)
  # * meals: %w{lunch dinner}, %w{lunch}, %w{dinner}
  # * neighborhood: "back-bay", etc
  # * phone: "617-555-1234"
  # * menu: use menu_link_for("lunch" || "dinner")
  # * map_link: a link to the RWB map page for that Restaurant
  class Restaurant
    include Comparable

    # +entry+ is a Nokogiri::XML::Node from the RWB web site.
    def initialize(entry)
      @entry = entry
    end

    # Compares this Restaurant's name to +other+'s name, and returns -1, 0, 1
    # as appropriate.
    def <=>(other)
      name <=> other.name
    end

    # Generate a pretty representation of the Restaurant.
    def to_s
      s = <<-EOS
Name: #{name}
Meals: #{meals.map(&:capitalize).join(', ')}
Neighborhood: #{neighborhood}
Phone: #{phone}
EOS
      @meals.each do |meal|
        s += "#{meal.capitalize} Menu: #{menu_link_for(meal)}"
        s += "\n"
      end
      s += "Map: #{map_link}"
      s
    end

    # Returns "<Restaurant: #{restaurant-name}>"
    def inspect
      "<Restaurant: #{name}>"
    end

    # Return the full name of this Restaurant, e.g. "224 Boston Street".
    def name
      @name ||= @entry.css('h4 a[href^="/restaurant"]').text.strip
    end

    private

    # Return the short name (e.g. '224-boston-street' for "224 Boston Street").
    def short_name
      @short_name ||= @entry[:id].sub('restaurantID-', '')
    end

    # Return a 0 to 2 element array containing the meals offered by this
    # Restaurant: "lunch" and/or "dinner".
    def meals
      @meals ||= find_meals
    end

    def find_meals
      meals = []
      unless @entry.xpath('.//strong[.="Lunch"]').empty?
        meals << 'lunch'
      end
      unless @entry.xpath('.//strong[.="Dinner"]').empty?
        meals << 'dinner'
      end
      meals
    end

    # Return the neighborhood this Restaurant is in (e.g. "Back Bay")
    def neighborhood
      @neighborhood ||= begin
        link = @entry.css('a[@href*="neighborhood"]').first
        ugly_neighborhood = link.attributes['href'].value.sub('/?neighborhood=', '')
        # back-bay -> "Back Bay"
        ugly_neighborhood.split('-').map(&:capitalize).join(' ')
      end
    end

    # Return this Restaurant's phone number, or "<no phone given>" is none is
    # provided.
    def phone
      @phone ||= begin
        # UGLY, but it's not wrapped in a tag so there isn't really a better
        # way.
        phone = @entry.css('.restaurantInfoBasic > p').children[6].to_s
        if phone == '<br>'
          '<no phone given>'
        else
          phone.sub(/^[^0-9]+/, '').strip
        end
      end
    end

    # Meal is either "lunch" or "dinner"
    def menu_link_for(meal)
      "http://www.restaurantweekboston.com/fetch/#{short_name}/#{meal}/"
    end

    # Return the URL to the map of this Restaurant at the RWB web site.
    def map_link
      "http://www.restaurantweekboston.com/map/#{neighborhood}/#{short_name}/#topOfMap"
    end
  end
end
