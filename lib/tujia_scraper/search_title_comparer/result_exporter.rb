# Output the result for a given city to a CSV.

module TujiaScraper
  module SearchTitleComparer
    class ResultExporter

      attr_reader :output, :city

      def initialize(output, city)
        @output = output
        @city = city
      end

      def export
        create_dir

        CSV.open(path_filename, "a+",
        write_headers: true,
        # TODO - Tie headers to the hash keys.
        headers: ["room_id", "title", "page_number", "city", Time.now]) do |csv|
          csv << output.pop #Adds the summary. TODO: Add this to the overall summary.

          output.each do |result|
            csv << result.values
          end
        end
      end

      private

      def path_filename
        "#{path}#{city}.csv"
      end

      def path
        "results/search_title_comparer/#{Date.today}/"
      end

      def create_dir
        FileUtils.mkdir_p "results/search_title_comparer/#{Date.today}/"
      end

    end
  end
end