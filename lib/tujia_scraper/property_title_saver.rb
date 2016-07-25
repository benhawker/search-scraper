module TujiaScraper
  class PropertyTitleSaver

    attr_reader :city, :property_titles

    def initialize(city)
      @city = city
      @property_titles = {} # Enables us to store { title: page_number, title: page_number }
    end

    def get_property_titles
      links = page.css("#idForMap > div > div.house-main-info > h2 > a")

      links.each do |link|
        property_title = link.attributes["title"].value
        page_number = 1

        property_titles[property_title] = page_number
      end
    end

    private

    def page
      Client.new(city).get_page
    end
  end
end

# Return:
# ts.property_titles ->
#   {
#     "海德公园行政公寓"=>1,
#     "牛津街考文特花园完美伦敦公寓"=>1,
#     "肯辛顿奥林匹亚时尚公寓"=>1,
#     "假日别墅"=>1,
#     "3间卧室独栋房屋"=>1,
#     "海德公园公寓"=>1,
#     "海德公园经济公寓"=>1,
#     "洛希尔农庄&乌托邦SPA"=>1,
#     "公园广场河畔俱乐部"=>1,
#     "帕丁顿公寓"=>1,
#     "市政厅豪华公寓"=>1,
#     "韦斯特套房"=>1,
#     "海德公园套房"=>1,
#     "伦敦南肯辛顿馨乐庭服务公寓"=>1,
#     "新市场旅馆"=>1,
#     "W12客房旅馆"=>1,
#     "Kilburn 2间适宜卧室公寓"=>1,
#     "大不列颠客栈"=>1,
#     "科豪斯民宿"=>1
#   }