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
      return name <=> other.name
    end


    # Generate a pretty representation of the Restaurant.
    def to_s
      # back-bay -> "Back Bay"
      pretty_neighborhood = neighborhood.split('-').map{|x| x.capitalize }.join(' ')

      s = "Name: #{name} (short-name: #{short_name})"
      s += "\n"
      s += "Meals: #{meals.map(&:capitalize).join(', ')}"
      s += "\n"
      s += "Neighborhood: #{pretty_neighborhood}"
      s += "\n"
      s += "Phone: #{phone}"
      @meals.each do |meal|
        s += "\n"
        s += "%s Menu: #{menu_link_for(meal)}" % [meal.capitalize]
      end
      s += "\n"
      s += "Map: #{map_link}"
      s
    end


    # Returns "<Restaurant: #{restaurant-name}>"
    def inspect
      "<Restaurant: #{name}>"
    end

    # Returns true if this Restaurant offers lunch.
    def offers_lunch?
      meals.include?('lunch')
    end

    # Returns true if this Restaurant offers dinner.
    def offers_dinner?
      meals.include?('dinner')
    end

    # Return the short name (e.g. '224-boston-street' for "224 Boston Street").
    def short_name
      @short_name ||= @entry[:id].sub('restaurantID-', '')
    end

    # Return the full name of this Restaurant, e.g. "224 Boston Street".
    def name
      unless @name
        # UGLY, but it's not wrapped in a tag so there it is.
        # split: ["224", "Boston", "Street", "[", "map", "]"]
        split = @entry.css('h4')[0].text.strip.split(/\s+/)
        # Remove [[", "map", "]"]
        split.slice!(-3, 3)
        @name = split.join(' ')
      end
      @name
    end

    # Return a 0-2 element array containing the meals offered by this
    # Restaurant: "lunch" and/or "dinner".
    def meals
      unless @meals
        @meals = []
        lunch = ! @entry.css('a.lunchMenuButton').empty?
        dinner = ! @entry.css('a.dinnerMenuButton').empty?
        @meals << 'lunch' if lunch
        @meals << 'dinner' if dinner
      end
      @meals
    end

    # Return the neighborhood this Restaurant is in (e.g. "back-bay").
    def neighborhood
      unless @neighborhood
        link = @entry.css('a[@href*="neighborhood"]').first
        @neighborhood = link.attributes['href'].value.sub('/?neighborhood=', '')
      end
      @neighborhood
    end


    # Return this Restaurant's phone number, or "<no phone given>" is none is
    # provided.
    def phone
      unless @phone
        # UGLY, but it's not wrapped in a tag so there it is.
        phone = @entry.css('.restaurantInfoBasic > p').children[6].to_s
        if phone == '<br>'
          @phone = '<no phone given>'
        else
          @phone = phone
        end
      end
      @phone
    end

    # +meal+ should be either "lunch" or "dinner"
    def menu_link_for(meal)
      if meal == 'lunch'
        @lunch_menu_link ||= "http://www.restaurantweekboston.com/fetch/#{short_name}/lunch/"
      elsif meal == 'dinner'
        @dinner_menu_link ||= "http://www.restaurantweekboston.com/fetch/#{short_name}/dinner/"
      end
    end


    # Return the URL to the map of this Restaurant at the RWB web site.
    def map_link
      @map_link ||= "http://www.restaurantweekboston.com/map/#{neighborhood}/#{short_name}/#topOfMap"
    end
  end
end
