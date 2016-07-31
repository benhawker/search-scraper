module TujiaScraper
  module IDComparer
    class Summarizer

      attr_reader :property_finder_output

      def initialize(property_finder_output)
        @property_finder_output = property_finder_output
      end

      def export
        create_dir

        File.open(path_filename, 'a+') do |file|
          summary.each { |key, value| file.write("#{key}: #{value}\n") }
        end
      end

      private

      def summary
        {
          :city => city,
          :number_of_properties_found => number_of_properties_found,
          :number_of_properties_in_tujia_list => number_of_properties_in_tujia_list,
          :number_of_properties_in_feed => number_of_properties_in_feed
        }
      end

      def number_of_properties_found
        property_finder_output.properties_found.size
      end

      def number_of_properties_in_tujia_list
        property_finder_output.properties_to_find.size
      end

      def number_of_properties_in_feed
        #TODO Do not recalculate if already stored in memory.(i.e. whole process is running) =||
        ::TujiaScraper::SearchTitleComparer::RMTitleImporter.new(city).read_from_csv.size
      end

      def city
        property_finder_output.city
      end

      def path_filename
        "#{path}summary.txt"
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

