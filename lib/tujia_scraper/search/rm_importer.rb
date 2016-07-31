# Read zh title from the RM database via a CSV we will regularly output.
# CSV will contain room_id, city (string), property title (in simplified Chinese)

module TujiaScraper
  module Search
    class RMImporter

      attr_reader :city, :property_titles

      def initialize(city)
        @city = city
        @property_titles = []
      end

      # We will import properties.csv into the root periodically.
      def read_from_csv
        CSV.foreach(path, headers: true, quote_char: "|") do |record|
          if record['city'] == city.to_s
            hash = { :title => record['title'], :rm_id => record['room_id'], :city => record['city'] }

            property_titles << hash
          end
        end
        property_titles
      end

      def path
        "properties/properties.csv"
      end

    end
  end
end

