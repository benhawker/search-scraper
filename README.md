Tujia.com search scraper + added ID comparison.
===================

A work in progress as of August 2016.

For both components you will require an input file, which must be loaded into `properties/`. The directory is gitignored.

Results will be output to a `results/`. The directory is also gitignored but will be create dynically by fileutils once the script runs.


===================

### Usage:

```
require_relative 'lib/tujia_scraper'

TujiaScraper::ID::EntryPoint.new(["london", "tokyo"]).generate

TujiaScraper::Search::EntryPoint.new(["london", "tokyo"]).generate

```

===================

### city_destination_id mapping

```
london 127
singapore 1476
tokyo 772
osaka 793
seoul 2074
jeju island 7295
pattaya 1290
bangkok 929
chiangmai 2088
phuket 1247
taipei 1700
hualian 4201 (*should be spelt 'Hualien'*)
kaohsiung 2717
hong kong 735
new york 2
san francisco 4506
los angeles 313

```