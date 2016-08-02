module TujiaScraper
  module Search
    class Comparer

      attr_reader :city, :rm, :tj, :output
      attr_accessor :number_of_rm_properties_found

      def initialize(city)
        @city = city
        @rm = rm_properties
        @tj = tj_properties
        @output = []
      end

      def compare
        found
        not_found

        export_summary
        export_results(output)
      end

      private

      def found
        found_count = 0

        rm.each do |rm_property|
          tj.each do |tj_property|
            #Strip whitespace to ensure we are comparing the same things - allows for formatting issues.
            rm_title = rm_property[:title].strip unless rm_property[:title].nil?
            tj_title = tj_property[:title].strip unless tj_property[:title].nil?

            #Do not add the second match - due to the nested iteration. TODO: Sort out this mess.
            if (rm_title == tj_title) && !output.any? {|h| h[:title] == rm_property[:title]}
              output << { :rm_id => rm_property[:rm_id], :title => rm_property[:title], :page => tj_property[:page], :city => city }
              found_count += 1
            end
          end
        end
        @number_of_rm_properties_found = found_count
      end

      def not_found
        titles = []
        tj.each { |t| titles << t[:title] }

        rm.each do |rm_property|
          unless titles.include?(rm_property[:title])
            output << { :rm_id => rm_property[:rm_id], :title => rm_property[:title], :page => "Not Found", :city => city }
          end
        end
      end

      def rm_properties
        RMImporter.new(city).read_from_csv
      end

      def tj_properties
        TJImporter.new(city).get_property_titles
      end

      # Total number of properties shown for given the give destination at Tujia.com
      def number_of_tj_properties
        tj.size
      end

      # Total number of properties contained in CSV dump for the given destination that meet
      # the scope (included in the feed) as defined by the Feed application.
      def number_of_rm_properties
        rm.size
      end

      def percentage_of_properties_found
        ((number_of_rm_properties_found.to_f / number_of_rm_properties.to_f) * 100).round(2)
      end

      def percentage_of_roomorama_properties_out_of_total_on_tujia
        ((number_of_rm_properties_found.to_f / number_of_tj_properties.to_f) * 100).round(2)
      end

      def export_results(output)
        ResultExporter.new(output, city).export
      end

      def export_summary
        summary = {
                    :type => "Tujia Search Result Title Comparison",
                    :date => Date.today,
                    :city => city,
                    :number_of_tj_properties => number_of_tj_properties,
                    :number_of_rm_properties => number_of_rm_properties,
                    :number_of_rm_properties_found => number_of_rm_properties_found,
                    :percentage_of_properties_found => percentage_of_properties_found,
                    :percentage_of_roomorama_properties_out_of_total_on_tujia => percentage_of_roomorama_properties_out_of_total_on_tujia
                  }

        Summarizer.new(summary).export
      end
    end
  end
end