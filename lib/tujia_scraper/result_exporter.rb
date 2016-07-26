# Output the result for a given city to a CSV.

module TujiaScraper
  class ResultExporter

    attr_reader :output

    def initialize(output)
      @output = output
    end

    def export
      CSV.open("results_#{Date.today}.csv", "a+",
      write_headers: true,
      headers: ["room_id","page_number","title", "city"]) do |csv|
        output.each do |result|
          csv << result
        end
      end
    end

  end
end
