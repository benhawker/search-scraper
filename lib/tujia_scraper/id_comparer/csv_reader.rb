module TujiaScraper
  module IDComparer
    class CSVReader

      attr_reader :city, :property_ids

      def initialize(city)
        @city = city
        @property_ids = []
      end

      # tj_id,rm_id,city,rm_destination_id
      def read_from_csv
        CSV.foreach(path, headers: true, quote_char: "|") do |record|
          if record['city'] == city.to_s
            # property_ids[record['rm_id']] = [record['tj_id'], record['city']]
            property_ids << { :rm_id => record['rm_id'], :tj_id => record['tj_id'], :city => record['city'] }
          end
        end
        property_ids
      end

      # We will import tj_rm_id.csv into the properties folder periodically.
      def path
        "properties/tj_rm_id.csv"
      end
    end
  end
end