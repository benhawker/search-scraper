# Output the result for a given city to a CSV.

module TujiaScraper
  class ResultExporter

    attr_reader :output

    def initialize(output)
      @output = output
    end

    # TODO: Append if the daily CSV is already created.
    # I.e. for the 2nd and further cities we process do not overwrite just append.
    def export
      CSV.open("results_#{Date.today}.csv", "a+",
      write_headers: true,
      headers: ["room_id","page_number","title"]) do |csv|
        output.each do |result|
          csv << result
        end
      end
    end

  end
end
