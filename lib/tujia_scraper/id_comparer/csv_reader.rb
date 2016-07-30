module TujiaScraper
  module IDComparer
    class CSVReader

      attr_reader :city, :property_ids

      def initialize(city)
        @city = city
        @property_ids = []
      end

      # tj_id,rm_id,city,rm_destination_id
      def read_from_csv
        CSV.foreach(path, headers: true, quote_char: "|") do |record|
          if record['city'] == city.to_s
            # property_ids[record['rm_id']] = [record['tj_id'], record['city']]
            property_ids << { :rm_id => record['rm_id'], :tj_id => record['tj_id'], :city => record['city'] }
          end
        end
        property_ids
      end

      # We will import tj_rm_id.csv into the properties folder periodically.
      def path
        "properties/tj_rm_id.csv"
      end
    end
  end
end

# Return:
# {"391843"=>["5057784", "london"], "190818"=>["5057807", "london"], "337484"=>["5057829", "london"], "338409"=>["5057840", "london"], "338636"=>["5057863", "london"], "389375"=>["5057865", "london"], "389385"=>["5057895", "london"], "389576"=>["5057919", "london"], "386175"=>["5057922", "london"], "386450"=>["5057932", "london"], "389901"=>["5057938", "london"], "389903"=>["5057958", "london"], "389904"=>["5057969", "london"], "389905"=>["5057980", "london"], "389906"=>["5057993", "london"], "389911"=>["5058015", "london"], "386845"=>["5058209", "london"], "405979"=>["5058250", "london"], "410170"=>["5058283", "london"], "408960"=>["5057065", "london"], "191361"=>["5063854", "london"], "191360"=>["5063869", "london"], "250894"=>["5057321", "london"], "365072"=>["5057398", "london"], "264774"=>["5057433", "london"], "264775"=>["5057442", "london"], "264776"=>["5057456", "london"], "264788"=>["5057466", "london"], "405980"=>["5057489", "london"], "405981"=>["5057502", "london"], "405982"=>["5057510", "london"], "405983"=>["5057521", "london"], "350712"=>["5057530", "london"], "405984"=>["5057533", "london"], "350760"=>["5057540", "london"], "405985"=>["5057545", "london"], "350761"=>["5057550", "london"], "405986"=>["5057556", "london"], "350762"=>["5057560", "london"], "405987"=>["5057568", "london"], "388934"=>["5057572", "london"], "405988"=>["5057578", "london"], "405989"=>["5057588", "london"], "133313"=>["5057729", "london"], "264241"=>["5057742", "london"], "391833"=>["5057773", "london"]}