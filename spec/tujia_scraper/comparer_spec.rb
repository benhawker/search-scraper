require "spec_helper"

RSpec.describe TujiaScraper::Comparer do
  let(:city) { "london" }
  let(:tj) { {"title_1"=>1, "title_2"=>1, "title_3"=>1 } }
  let(:rm) { {"title_1"=>["london", "1"], "title_2"=>["london", "2"]} }

  describe "#compare" do
    before do
      allow_any_instance_of(described_class).to receive(:rm_properties).and_return(rm)
      allow_any_instance_of(described_class).to receive(:tj_properties).and_return(tj)
    end

    it "correctly populates the output" do
      expected_result = [["1", "title_1", 1, "london"], ["2", "title_2", 1, "london"], ["1", "title_1", 1, "london"], ["2", "title_2", 1, "london"]]
      subject = described_class.new(city)
      subject.compare
      expect(subject.output).to eq (expected_result)
    end
  end
end
