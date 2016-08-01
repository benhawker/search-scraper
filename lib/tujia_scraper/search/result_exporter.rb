# Output the result for a given city to a CSV.

module TujiaScraper
  module Search
    class ResultExporter

      attr_reader :output, :city

      def initialize(output, city)
        @output = output
        @city = city
      end

      def export
        return if output.empty?
        create_dir

        CSV.open(path_filename, "a+", headers: output.first.keys << Time.now) do |csv|
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
        "results/search/#{Date.today}/"
      end

      def create_dir
        FileUtils.mkdir_p "results/search/#{Date.today}/"
      end

    end
  end
end