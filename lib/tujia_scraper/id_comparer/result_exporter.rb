# Output the result for a given city to a CSV.

module TujiaScraper
  module IDComparer
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
        headers: ["title","tj_id","city"]) do |csv|
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
        "results/id_comparer/#{Date.today}/"
      end

      def create_dir
        FileUtils.mkdir_p(path)
      end

    end
  end
end