# The entry point for a user & the scheduler.
# Optionally pass an array of cities (for a reduced list) or use the full list given in the cities.yml.
# Usage: TujiaScraper::EntryPoint.new.generate - for all specified cities
# Usage: TujiaScraper::EntryPoint.new(["london", "singapore"]).generate
# Usage: TujiaScraper::EntryPoint.new(["london"]).generate

module TujiaScraper
  class EntryPoint

    CITIES = YAML::load(File.open(File.join('lib', 'tujia_scraper', 'cities.yml')))

    attr_reader :cities

    def initialize(cities=nil)
      @cities = cities || CITIES.keys
    end

    def generate
      raise InvalidCitySpecified.new(cities) unless valid_cities?(cities)

      cities.each do |city|
        comparer = Comparer.new(city).compare
        puts comparer #to be removed.
        comparer
      end
    end

    def valid_cities?(cities)
      cities.each do |city|
        return false unless CITIES.keys.include?(city)
      end
    end

  end
end