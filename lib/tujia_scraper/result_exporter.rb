# Output the result for a given city to a CSV.

module TujiaScraper
  class ResultExporter

    attr_reader :output

    def initialize(output)
      @output = output
    end

    def export
      create_dir

      CSV.open(path_filename, "a+",
      write_headers: true,
      headers: ["room_id","page_number","title", "city", Time.now]) do |csv|
        csv << output.pop

        output.each do |result|
          csv << result
        end
      end
    end

    private

    def path_filename
      "results/#{Date.today}/#{output[0][-1]}.csv"
    end

    def create_dir
      FileUtils.mkdir_p "results/#{Date.today}/"
    end

  end
end