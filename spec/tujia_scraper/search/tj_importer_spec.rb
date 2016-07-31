require "spec_helper"

RSpec.describe TujiaScraper::Search::TJImporter do

  let(:city) { "london" }
  subject { described_class.new(city) }

  describe "#get_property_titles" do
    before do
      response = {"肯辛顿奥林匹亚时尚公寓"=>1, "牛津街考文特花园完美伦敦公寓"=>1, "1号曼斯里大厦三室两卫公寓"=>2 }
      allow(subject).to receive(:get_property_titles).and_return(response)
    end

    it "returns a hash with the scraped property title and page it was found on in the search results" do
      expect(subject.get_property_titles).to eq ({"肯辛顿奥林匹亚时尚公寓"=>1, "牛津街考文特花园完美伦敦公寓"=>1, "1号曼斯里大厦三室两卫公寓"=>2 })
    end
  end
end