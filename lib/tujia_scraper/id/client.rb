module TujiaScraper
  module ID
    class Client

      BASE_URL = "http://international.tujia.com/"
      CITIES = YAML::load(File.open(File.join('lib', 'tujia_scraper', 'id', 'cities.yml')))

      attr_reader :city, :id

      def initialize(city, id)
        @city = city
        @id = id
      end

      def get
        http_client.get(url_builder)
      end

      private

      def http_client
        Mechanize.new
      end

      # Example: http://international.tujia.com/lundun_u5048914.htm
      def url_builder
        BASE_URL + CITIES[city] + "_" + "u" + id + ".htm"
      end
    end
  end
end