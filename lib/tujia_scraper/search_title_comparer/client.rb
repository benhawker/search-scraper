module TujiaScraper
  module SearchTitleComparer
    class Client

      BASE_URL = "http://international.tujia.com/"
      CITIES = YAML::load(File.open(File.join('lib', 'tujia_scraper', 'search_title_comparer', 'cities.yml')))

      attr_reader :city, :page

      def initialize(city, page=1)
        @city = city
        @page = page
      end

      def get
        http_client.get(url_builder)
      end

      private

      def http_client
        Mechanize.new
      end

      # Example: http://international.tujia.com/basailuona_gongyu_r24/1
      def url_builder
        BASE_URL + CITIES[city] + page.to_s
      end

    end
  end
end