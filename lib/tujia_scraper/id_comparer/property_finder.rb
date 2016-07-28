## Basic initial check to see if the property is actually valid and returning a page.

module TujiaScraper
  module IDComparer
    class PropertyFinder

      attr_reader :city, :properties_to_find, :properties_found, :result

      def initialize(city)
        @city = city
        @properties_to_find = get_properties_list(city)
        @properties_found = []
        # @result = []
      end

      def find_and_save
        find
        write_to_csv
      end

      private

      # {"391843"=>["5057784", "london"]}
      def write_to_csv
        CSV.open(path_filename, "a+",
        write_headers: true,
        headers: ["rm_id","tj_id","city"]) do |csv|
          properties_found.each do |result|
            csv << result
          end
        end
      end


      def find
        properties_to_find.each do |key, value|
          begin
            response = get_property(value[1], value[0])

            #Store the property titles to compare vs. our search title comparison results. TODO Refactor these chained gsub calls.
            title = get_property(value[1], value[0]).css("body > div:nth-child(6) > div > h1").text.gsub(/\s+$/, '').gsub(/\n/, "")
            properties_found << [title, value[1], value[0]]

          rescue Mechanize::ResponseCodeError
            #Display in the console any properties that we cannot find that are in the Tujia list provided.
            puts "RM ID: #{key} with TJ ID: #{value[0]} in #{value[1]} not found"
          end
        end
      end

      def get_property(city, id)
        Client.new(city, id).get
      end

      def get_properties_list(city)
        CSVReader.new(city).read_from_csv
      end

      #Need to add city to this.
      def path_filename
        "results/id_comparer/#{Date.today}.csv"
      end

    end
  end
end