every 1.week, :at => '12:00 am' do
  runner TujiaScraper::EntryPoint.new
end