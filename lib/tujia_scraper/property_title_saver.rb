module TujiaScraper
  class PropertyTitleSaver

    attr_reader :city, :property_titles

    def initialize(city)
      @city = city
      @property_titles = {} # Enables us to store { title: page_number, title: page_number }
    end

    def get_property_titles
      page_number = 1

      until get_page(page_number).css("#idForMap > div > div.house-main-info > h2 > a").empty?
        links = get_page(page_number).css("#idForMap > div > div.house-main-info > h2 > a")

        links.each do |link|
          property_title = link.attributes["title"].value
          property_titles[property_title] = page_number
        end

        page_number += 1
      end
      property_titles
    end

    private

    def get_page(page_number)
      Client.new(city, page_number).get
    end
  end
end

# Return:
# ts.property_titles ->
#   {
#     "海德公园行政公寓"=>1,
#     "牛津街考文特花园完美伦敦公寓"=>1,
#     "肯辛顿奥林匹亚时尚公寓"=>1,
#     "韦斯特套房"=>2,
#     "海德公园套房"=>2,
#     "伦敦南肯辛顿馨乐庭服务公寓"=>2,
#     "新市场旅馆"=>2,
#     "W12客房旅馆"=>2,
#     "Kilburn 2间适宜卧室公寓"=>2,
#     "大不列颠客栈"=>3,
#     "科豪斯民宿"=>3
#   }