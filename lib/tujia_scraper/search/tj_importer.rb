module TujiaScraper
  module Search
    class TJImporter

      attr_reader :city, :property_titles

      def initialize(city)
        @city = city
        @property_titles = []
      end

      def get_property_titles
        page_number = 1

        until get_page(page_number).css("#idForMap > div > div.house-main-info > h2 > a").empty?
          links = get_page(page_number).css("#idForMap > div > div.house-main-info > h2 > a")

          links.each do |link|
            property_title = link.attributes["title"].value
            property_titles << { :title => property_title, :page => page_number}
          end

          page_number += 1
        end
        property_titles
      end
      #Return [{"title"=>"牛津街考文特花园完美伦敦公寓", "page"=>1}, {"title"=>"1号曼斯里大厦三室两卫公寓", "page"=>1}]

      private

      def get_page(page_number)
        Client.new(city, page_number).get
      end
    end
  end
end