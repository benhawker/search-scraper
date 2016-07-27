# Output the result for a given city to a CSV.

module TujiaScraper
  class ResultExporter

    attr_reader :output

    def initialize(output)
      @output = output
    end

    def export
      CSV.open("results/#{output[0][-1]}_#{Date.today}.csv", "a+",
      write_headers: true,
      headers: ["room_id","page_number","title", "city", Time.now]) do |csv|
        csv << output.pop

        output.each do |result|
          csv << result
        end
      end
    end

  end
end
