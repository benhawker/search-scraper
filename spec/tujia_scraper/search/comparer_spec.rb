require "spec_helper"

RSpec.describe TujiaScraper::Search::Comparer do
  let(:city) { "london" }
  let(:tj) { [{"title"=>"牛津街考文特花园完美伦敦公寓", "page"=>1}, {"title"=>"1号曼斯里大厦三室两卫公寓", "page"=>1}] }
  let(:rm) { [{:title=>"title_1", :rm_id=>"1", :city=>"london"}, {:title=>"title_2", :rm_id=>"2", :city=>"london"}] }

  describe "#compare" do
    before do
      allow_any_instance_of(described_class).to receive(:rm_properties).and_return(rm)
      allow_any_instance_of(described_class).to receive(:tj_properties).and_return(tj)
    end

    it "correctly populates the output" do
      expected_result = [{:rm_id=>"1", :title=>"title_1", :page=>"Not Found", :city=>"london"}, {:rm_id=>"2", :title=>"title_2", :page=>"Not Found", :city=>"london"}]
      subject = described_class.new(city)
      subject.compare
      expect(subject.output).to eq (expected_result)
    end
  end
end
