require "mechanize"
require "csv"
require "json"
require "yaml"
require "fileutils"

require_relative "tujia_scraper/search_title_comparer/client"
require_relative "tujia_scraper/search_title_comparer/property_title_saver"
require_relative "tujia_scraper/search_title_comparer/rm_title_importer"
require_relative "tujia_scraper/search_title_comparer/comparer"
require_relative "tujia_scraper/search_title_comparer/result_exporter"
require_relative "tujia_scraper/search_title_comparer/entry_point"

require_relative "tujia_scraper/id_comparer/client"
require_relative "tujia_scraper/id_comparer/csv_reader"
require_relative "tujia_scraper/id_comparer/property_finder"
require_relative "tujia_scraper/id_comparer/entry_point"

# require_relative "tujia_scraper"

module TujiaScraper
  module SearchTitleComparer
    class InvalidCitySpecified < StandardError
      def initialize(cities)
        super("One of your requested cities: #{cities} is not valid. Valid cities are: #{Client::CITIES.keys}")
      end
    end
  end
end

module TujiaScraper
  module IDComparer
    class InvalidCitySpecified < StandardError
      def initialize(cities)
        super("One of your requested cities: #{cities} is not valid. Valid cities are: #{Client::CITIES.keys}")
      end
    end
  end
end