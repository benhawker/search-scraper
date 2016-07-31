## Basic initial check to see if the property is actually valid and returning a page.

module TujiaScraper
  module ID
    class TJImporter

      attr_reader :city, :properties_to_find, :properties_found

      def initialize(city)
        @city = city
        @properties_to_find = get_properties_list(city)
        @properties_found = []
      end

      def find_and_save
        find
        summarize
        export_results(properties_found)
      end

      private

      def find
        properties_to_find.each do |property|
          begin
            # Call the client passing the city and the id to build the URL.
            response = get_property(property[:city], property[:tj_id])

            # Store the property titles to compare vs. our search title comparison results.
            # TODO Refactor these chained gsub calls. Many flaws not being caught.
            title = response.css("body > div:nth-child(6) > div > h1").text.gsub(/\s+$/, '').gsub(/\n/, "")
            properties_found << { :title => title, :tj_id => property[:tj_id], :city => property[:city] }

          rescue Mechanize::ResponseCodeError
            # Display in the console any properties that we cannot find that are in the Tujia list provided.
            puts "RM ID: #{property[:rm_id]} with TJ ID: #{property[:tj_id]} in #{property[:city]} not found"
          end
        end
      end

      def summarize
        Summarizer.new(self, city).export
      end

      def get_property(city, id)
        Client.new(city, id).get
      end

      def get_properties_list(city)
        CSVReader.new(city).read_from_csv
      end

      def export_results(output)
        ResultExporter.new(output, city).export
      end

    end
  end
end