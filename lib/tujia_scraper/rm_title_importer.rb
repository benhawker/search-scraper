# Read zh title from the RM database via a CSV we will regularly output.
# CSV will contain room_id, city (string), property title (in simplified Chinese)

module TujiaScraper
  class RMTitleImporter

    attr_reader :city, :property_titles

    def initialize(city)
      @city = city
      @property_titles = {}
    end

    # We will import properties.csv into the root periodically.
    def read_from_csv
      CSV.foreach("test_properties.csv", headers: true, quote_char: "|") do |record|
        if record['city'] == city.to_s
          property_titles[record['title']] = [record['city'], record['room_id']]
        end
      end
      property_titles
    end

  end
end
