require "mechanize"
require "csv"
require "json"
require "yaml"
require "fileutils"

require_relative "tujia_scraper/search/client"
require_relative "tujia_scraper/search/tj_importer"
require_relative "tujia_scraper/search/rm_importer"
require_relative "tujia_scraper/search/comparer"
require_relative "tujia_scraper/search/result_exporter"
require_relative "tujia_scraper/search/summarizer"
require_relative "tujia_scraper/search/entry_point"

require_relative "tujia_scraper/id/client"
require_relative "tujia_scraper/id/csv_reader"
require_relative "tujia_scraper/id/tj_importer"
require_relative "tujia_scraper/id/result_exporter"
require_relative "tujia_scraper/id/summarizer"
require_relative "tujia_scraper/id/entry_point"

require_relative "tujia_scraper/report"

module TujiaScraper
  module Search
    class InvalidCitySpecified < StandardError
      def initialize(cities)
        super("One of your requested cities: #{cities} is not valid. Valid cities are: #{Client::CITIES.keys}")
      end
    end
  end
end

module TujiaScraper
  module ID
    class InvalidCitySpecified < StandardError
      def initialize(cities)
        super("One of your requested cities: #{cities} is not valid. Valid cities are: #{Client::CITIES.keys}")
      end
    end
  end
end