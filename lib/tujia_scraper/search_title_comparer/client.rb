module TujiaScraper
  module SearchTitleComparer
    class Client

      BASE_URL = "http://international.tujia.com/"
      CITIES = YAML::load(File.open(File.join('lib', 'tujia_scraper', 'search_title_comparer', 'cities.yml')))

      attr_reader :city, :page, :start_date, :end_date, :guest_count

      # Currently not using most of these optional arguments. Refactor usage into entry_point class.
      def initialize(city, page=1, start_date=nil, end_date=nil, guest_count=nil)
        @city = city
        @page = page
        @start_date = start_date
        @end_date = end_date
        @guest_count = guest_count
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
        url = BASE_URL + CITIES[city] + page.to_s
        url += params_builder if params?
        url
      end

      # TODO: Allow flexibility to now have to pass all params.
      def params?
        start_date && end_date && guest_count
      end

      def params_builder
        "?startDate=#{start_date}&endDate=#{start_date}&guestCount=#{guest_count}"
      end

    end
  end
end