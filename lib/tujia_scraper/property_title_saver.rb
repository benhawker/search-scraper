module TujiaScraper
  class PropertyTitleSaver

    attr_reader :city, :property_titles

    def initialize(city)
      @city = city
      @property_titles = {} # Enables us to store { title: page_number, title: page_number }
    end

    def get_property_titles
      page_number = 1

      until get_page(page_number).css("#idForMap > div > div.house-main-info > h2 > a").empty?
        links = get_page(page_number).css("#idForMap > div > div.house-main-info > h2 > a")

        links.each do |link|
          property_title = link.attributes["title"].value
          property_titles[property_title] = page_number
        end

        page_number += 1
      end
      property_titles
    end

    private

    def get_page(page_number)
      Client.new(city, page_number).get
    end
  end
end