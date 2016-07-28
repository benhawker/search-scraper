require "spec_helper"

RSpec.describe TujiaScraper::RMTitleImporter do

  let(:city) { "london" }
  subject { described_class.new(city) }


  describe "#read_from_csv" do
    context "for the given city" do
      before do
        allow(subject).to receive(:path).and_return("spec/assets/properties.csv")
      end

      it "returns a hash" do
        property_titles_hash = {"title_1"=>["london", "1"], "title_2"=>["london", "2"]}
        expect(subject.read_from_csv).to eq (property_titles_hash)
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