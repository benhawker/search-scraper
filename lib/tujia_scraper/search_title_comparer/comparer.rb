module TujiaScraper
  module SearchTitleComparer
    class Comparer

      attr_reader :city, :rm, :tj, :output
      attr_accessor :number_of_rm_properties_found

      def initialize(city)
        @city = city
        @rm = rm_properties
        @tj = tj_properties
        @number_of_rm_properties_found = 0
        @output = []
      end

      def compare
        found
        not_found

        export_summary
        export_results(output)
      end

      private

      def found
        found_count = 0

        rm.each do |rm_property|
          tj.each do |tj_property|
            #Do not add the second match - due to the nested iteration. TODO: Refactor!
            if (rm_property[:title] == tj_property[:title]) && (!output.any? {|h| h[:title] == rm_property[:title]})
              output << { :rm_id => rm_property[:rm_id], :title => rm_property[:title], :page => tj_property[:page], :city => city }
              found_count += 1
            end
          end
        end
        @number_of_rm_properties_found = found_count
      end

      def not_found
        titles = []
        tj.each { |t| titles << t[:title] }

        rm.each do |rm_property|
          unless titles.include?(rm_property[:title])
            output << { :rm_id => rm_property[:rm_id], :title => rm_property[:title], :page => "Not Found", :city => city }
          end
        end
      end

      def rm_properties
        RMTitleImporter.new(city).read_from_csv
      end

      def tj_properties
        PropertyTitleSaver.new(city).get_property_titles
      end

      # Total number of properties included in the feed that we find in the search results.
      def number_of_rm_properties_found
        @number_of_rm_properties_found
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
        ResultExporter.new(output, city).export
      end

      #TODO - Refactor.
      def export_summary
        output << [
          "For #{city}:
    => Number of TJ Properties: #{number_of_tj_properties},
    => Number of RM Properties sent in feed: #{number_of_rm_properties},
    => Number of RM Properties Found: #{number_of_rm_properties_found}"
        ]
      end

    end
  end
end