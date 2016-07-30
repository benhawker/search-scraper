# The entry point for a user & the scheduler for the IDComparer

module TujiaScraper
  module IDComparer
    class EntryPoint

      CITIES = YAML::load(File.open(File.join('lib', 'tujia_scraper', 'id_comparer', 'cities.yml')))

      attr_reader :cities

      def initialize(cities=nil)
        @cities = cities || CITIES.keys
      end

      def generate
        raise InvalidCitySpecified.new(cities) unless valid_cities?(cities)

        cities.each do |city|
          PropertyFinder.new(city).find_and_save
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
end