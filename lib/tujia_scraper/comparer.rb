module TujiaScraper
  class Comparer

    attr_reader :city, :rm, :tj

    def initialize(city)
      @city = city
      @rm = rm_properties
      @tj = tj_properties
    end

    def compare
      (rm.keys & tj.keys).each do |key|
        puts ( rm[key] == tj[key] ? rm[key] : key ) #To be changed. Just a hack.
      end
    end

    private

    def rm_properties
      RMTitleImporter.new(city).read_from_csv
    end

    def tj_properties
      PropertyTitleSaver.new(city).get_property_titles
    end

  end
end

# tj
#   {
#     "海德公园行政公寓"=>1,
#     "牛津街考文特花园完美伦敦公寓"=>1,
#   }

# rm
# {"海德公园行政公寓"=>"london", "牛津街考文特花园完美伦敦公寓"=>"london", "肯辛顿奥林匹亚时尚公寓"=>"london"}