require "spec_helper"

RSpec.describe TujiaScraper::RMTitleImporter do

  let(:city) { "london" }
  subject { described_class.new(city) }


  describe "#read_from_csv" do
    context "for the given city" do
      it "returns a hash" do
        # expect(subject.read_from_csv).to eq {}
      end
    end

    context "for another city" do
      it "it does not include it in the returned hash" do

      end
    end
  end
end
