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
          # Try both styles of URL for the given property.
          [:get, :get_alt].each do |call|
            begin
              # Call the client trying both URL formats.
              response = client(property[:city], property[:tj_id]).send("#{call}")

              # Store the property titles to compare vs. our search title comparison results.
              # TODO: Refactor these chained gsub calls. Many flaws not being caught.
              title = response.css("body > div:nth-child(6) > div > h1").text.gsub(/\s+$/, '').gsub(/\n/, "")

              properties_found << { :title => title, :tj_id => property[:tj_id], :city => property[:city] }

            rescue Mechanize::ResponseCodeError
              # Display in the console any properties that we cannot find that are in the Tujia list provided.
              # TODO: Return only one failure for each property in the console output.
              puts "RM ID: #{property[:rm_id]} with TJ ID: #{property[:tj_id]} in #{property[:city]} not found"
            end
          end
        end
      end

      def summarize
        Summarizer.new(self, city).export
      end

      def client(city, id)
        Client.new(city, id)
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