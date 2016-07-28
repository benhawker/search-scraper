module TujiaScraper
  module SearchTitleComparer
    class Comparer

      attr_reader :city, :rm, :tj, :output

      def initialize(city)
        @city = city
        @rm = rm_properties
        @tj = tj_properties
        @output = []
      end

      def compare
        found
        not_found

        output << [
          "For #{city}:
    => Number of TJ Properties: #{number_of_tj_properties},
    => Number of RM Properties #{number_of_rm_properties},
    => Number of RM Properties Found: #{number_of_rm_properties_found}"
        ]

        export_results(output)
      end

      private

      #List out properties that we share that we find for a given city.
      def found
        found_count = 0
        rm.keys.each do |rm_title|
          tj.each do |tj_title, page|
            if rm_title == tj_title
              found_count += 1
              output << [rm[rm_title][1], rm_title, page, city]
            end
          end
        end
        found_count
      end

      #List out properties that we share that we do not find for a given city.
      def not_found
        not_found = rm.keys - tj.keys

        rm.each do |rm_title, arr|
          if not_found.include?(rm_title)
            output << [arr[1], rm_title, "Not Found", city]
          end
        end
      end

      def rm_properties
        RMTitleImporter.new(city).read_from_csv
      end

      def tj_properties
        PropertyTitleSaver.new(city).get_property_titles
      end

      def number_of_rm_properties_found
        found
      end

      # Total number of properties shown for given the give destination at Tujia.com
      def number_of_tj_properties
        tj.size
      end

      # Total number of properties contained in CSV dump for the given destination that meet
      # the scope (included in the feed) as defined by the Feed application.
      def number_of_rm_properties
        rm.size
      end

      def export_results(output)
        ResultExporter.new(output).export
      end
    end
  end
end