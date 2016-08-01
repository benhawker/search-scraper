module TujiaScraper
  module ID
    class Summarizer

      attr_reader :property_finder_output, :city

      def initialize(property_finder_output, city)
        @property_finder_output = property_finder_output
        @city = city
      end

      def export
        create_dir

        File.open(path_filename, 'a+') do |file|
          summary.each do |key, value|
            file.write("#{key}: #{value}\n")
          end
          file.write("\n")
        end
      end

      private

      def summary
        {
          :type => "TJ ID vs RM ID Comparison",
          :date => Date.today,
          :city => city,
          :number_of_properties_in_tujia_list => number_of_properties_in_tujia_list,
          :number_of_properties_found => number_of_properties_found
        }
      end

      def number_of_properties_found
        property_finder_output.properties_found.size
      end

      def number_of_properties_in_tujia_list
        property_finder_output.properties_to_find.size
      end

      def city
        property_finder_output.city
      end

      def path_filename
        "#{path}summary.txt"
      end

      def path
        "results/"
      end

      def create_dir
        FileUtils.mkdir_p(path)
      end
    end
  end
end

