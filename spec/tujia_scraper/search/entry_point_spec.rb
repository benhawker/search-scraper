require "spec_helper"

RSpec.describe TujiaScraper::Search::EntryPoint do

  let(:cities) { ["london"] }
  subject { described_class.new(cities) }

  describe "#generate" do
    it "raises an error if the city is not specified" do
      error_message = 'One of your requested cities: ["Moscow"] is not valid. Valid cities are: ["london", "singapore", "tokyo", "osaka", "seoul", "jeju island", "pattaya", "bangkok", "chiang mai", "phuket", "taipei", "hong kong", "new york", "san francisco", "los angeles"]'
      cities = ["Moscow"]
      expect { described_class.new(cities).generate }.to raise_error(error_message)
    end
  end
end