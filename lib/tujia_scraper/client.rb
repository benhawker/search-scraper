module TujiaScraper
  class Client

    BASE_URL = "http://international.tujia.com/"

    CITIES = {
               london: "lundun_gongyu_r17/",
               singapore: "xinjiapo_gongyu_r104/",
               tokyo: "dongjing_gongyu_r77/",
               osaka: "daban_gongyu_r147/"
             }

    attr_reader :city, :start_date, :end_date, :guest_count

    def initialize(city, start_date=nil, end_date=nil, guest_count=nil)
      @city = city
      @start_date = start_date
      @end_date = end_date
      @guest_count = guest_count
    end

    def get_page
      http_client.get(url_builder)
    end

    private

    def http_client
      Mechanize.new
    end

    def url_builder
      url = BASE_URL + CITIES[city.to_sym]
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

# page.link_with(:text => '海德公园行政公寓').resolved_uri
# <a href="/lundun_u5019232.htm#index=1" target="_blank" title="海德公园行政公寓">海德公园行政公寓</a></h2>
# //*[@id="idForMap"]/div[1]/div[1]/h2/a
# #idForMap > div:nth-child(1) > div.house-main-info > h2 > a

# page.css("#idForMap > div:nth-child(1) > div.house-main-info > h2 > a")

# 2.2.1 :088 > page.css("#idForMap > div:nth-child(1) > div.house-main-info > h2 > a")[0].attributes["title"].value
#  => "海德公园行政公寓"