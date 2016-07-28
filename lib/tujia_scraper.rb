require "mechanize"
require "csv"
require "json"
require "yaml"
require "fileutils"

require_relative "tujia_scraper/client"
require_relative "tujia_scraper/property_title_saver"
require_relative "tujia_scraper/rm_title_importer"
require_relative "tujia_scraper/comparer"
require_relative "tujia_scraper/result_exporter"
require_relative "tujia_scraper/entry_point"


module TujiaScraper
  class InvalidCitySpecified < StandardError
    def initialize(cities)
      super("One of your requested cities: #{cities} is not valid. Valid cities are: #{Client::CITIES.keys}")
    end
  end
end