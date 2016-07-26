module TujiaScraper
  class Comparer

    attr_reader :city, :rm, :tj, :output

    def initialize(city)
      @city = city
      @rm = rm_properties
      @tj = tj_properties
      @output = []
    end

    def compare
      found
      not_found

      export_results(output)
    end

    private

    #List out properties that we share that we find for a given city.
    def found
      rm.keys.each do |rm_title|
        tj.each do |tj_title, page|
          if rm_title == tj_title
            output << [rm[rm_title][1], rm_title, page]
          end
        end
      end
    end

    #List out properties that we share that we do not find for a given city.
    def not_found
      not_found = rm.keys - tj.keys

      rm.each do |rm_title, arr|
        if not_found.include?(rm_title)
          output << [arr[1], rm_title, "Not found"]
        end
      end
    end

    def rm_properties
      RMTitleImporter.new(city).read_from_csv
    end

    def tj_properties
      PropertyTitleSaver.new(city).get_property_titles
    end

    def export_results(output)
      ResultExporter.new(output).export
    end
  end
end