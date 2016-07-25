module TujiaScraper
  class Client

    BASE_URL = "http://international.tujia.com/"

    CITIES = {
               london: "lundun_gongyu_r17/",
               singapore: "xinjiapo_gongyu_r104/",
               tokyo: "dongjing_gongyu_r77/",
               osaka: "daban_gongyu_r147/"
             }

    attr_reader :city, :page, :start_date, :end_date, :guest_count

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

    # http://international.tujia.com/basailuona_gongyu_r24/1
    def url_builder
      url = BASE_URL + CITIES[city.to_sym] + page.to_s
      url += params_builder if params?
      url
    end

    def params?
      start_date && end_date && guest_count
    end

    def params_builder
      "?startDate=#{start_date}&endDate=#{start_date}&guestCount=#{guest_count}"
    end

  end
end