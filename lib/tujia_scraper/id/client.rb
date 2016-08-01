module TujiaScraper
  module ID
    class Client

      INT_URL = "http://international.tujia.com/"
      BASE_URL = "http://tujia.com/"

      CITIES = YAML::load(File.open(File.join('lib', 'tujia_scraper', 'id', 'cities.yml')))
      ALT_CITIES = YAML::load(File.open(File.join('lib', 'tujia_scraper', 'id', 'alt_cities.yml')))

      attr_reader :city, :id

      def initialize(city, id)
        @city = city
        @id = id
      end

      def get
        http_client.get(url_builder)
      end

      def get_alt
        http_client.get(alt_url_builder)
      end

      private

      def http_client
        Mechanize.new
      end

      # Example: http://international.tujia.com/lundun_u5058209.htm
      def url_builder
        INT_URL + CITIES[city] + "_" + "u" + id + ".htm"
      end

      # Some properties/cities use a different style of url where we are redirected back to Tujia.com.
      # Example: http://www.tujia.com/lundun_gongyu/lundun_78602.htm
      # This alternative is specified in tujia_scraper/id/alt_cities.yml.
      def alt_url_builder
        BASE_URL + ALT_CITIES[city] + "_" + id + ".htm"
      end
    end
  end
end