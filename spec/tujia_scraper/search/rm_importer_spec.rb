require "spec_helper"

RSpec.describe TujiaScraper::Search::RMImporter do

  let(:city) { "london" }
  subject { described_class.new(city) }


  describe "#read_from_csv" do
    context "for the given city" do
      before do
        allow(subject).to receive(:path).and_return("spec/assets/properties.csv")
      end

      it "returns a hash" do
        property_titles_array_of_hashes = [{:title=>"title_1", :rm_id=>"1", :city=>"london"}, {:title=>"title_2", :rm_id=>"2", :city=>"london"}]
        expect(subject.read_from_csv).to eq (property_titles_array_of_hashes)
      end
    end

    context "for another city" do
      it "it does not include it in the returned hash" do
        expect(subject.read_from_csv).not_to include ("osaka")
      end
    end

    context "when the csv is invalid" do
      before do
        allow(subject).to receive(:path).and_return("spec/assets/invalid_properties.csv")
      end

      it "returns an error" do
        subject.stub(:read_from_csv).and_return "Malformed CSV"
        expect(subject.read_from_csv).to eq "Malformed CSV"
      end
    end
  end
end