module TujiaScraper
  module Search
    class Summarizer

      attr_reader :summary

      def initialize(summary)
        @summary = summary
      end

      def export
        create_dir

        File.open(path_filename, 'a+') do |file|
          summary.each { |key, value| file.write("#{key}: #{value}\n") }
        end
      end

      private

      def path_filename
        "#{path}summary.txt"
      end

      def path
        "results/search/#{Date.today}/"
      end

      def create_dir
        FileUtils.mkdir_p(path)
      end
    end
  end
end

