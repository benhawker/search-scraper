require "spec_helper"

RSpec.describe TujiaScraper::SearchTitleComparer::ResultExporter do
  let(:output) { [["1", "title_1", 1, "london"], ["2", "title_2", 2, "london"]] }
  subject { described_class.new(output) }

  describe "#export" do
    before do
      allow(subject).to receive(:path_filename).and_return("spec/assets/results/my_test_csv.csv")
      subject.export
    end

    it "creates a csv and writes the results to it" do
      file = File.read("spec/assets/results/my_test_csv.csv")
      expect(file).to include ("2,title_2,2,london\n1,title_1,1,london")
    end

    after do
      File.delete("spec/assets/results/my_test_csv.csv")
    end
  end
end


