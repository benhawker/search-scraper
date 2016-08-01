module TujiaScraper
  class Report

    # Entry point of this class. You can optionally pass it an array of cities
    # to narrow down your report requirements.
    def self.generate(cities=nil)
      new(cities).generate!
    end

    CITIES = YAML::load(File.open(File.join('lib', 'tujia_scraper', 'search', 'cities.yml')))

    attr_reader :cities

    # Create a new report instance.
    def initialize(cities=nil)
      @cities = cities || CITIES.keys
    end

    def generate!
      raise InvalidCitySpecified.new(cities) unless valid_cities?(cities)

      cities.each do |city|
        Search::Comparer.new(city).compare
        ID::TJImporter.new(city).find_and_save
      end
    end

    private

    def valid_cities?(cities)
      cities.each do |city|
        return false unless CITIES.keys.include?(city)
      end
    end

  end
end