# Gifantry

Gifantry is a Rails based web app that allows bulk upload and tagging/categorization of images. It provides full text search and quick direct link copy. It has Facebook login as well as traditional email based login.

## Installation

Clone this repo

```
git clone https://github.com/DiegoSalazar/gifantry.git
cd gifantry
bundle
rake db:create db:setup db:migrate
```

Run the tests

```
rspec
```

## Usage

Start the server

```
rails s -p 3000
```

Open it in your browser

```
open http://localhost:3000
```

## Contributing

1. Fork it ( https://github.com/DiegoSalazar/gifantry/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
