####Setup Instructions:

This is built on Sinatra

 - Clone the repo
 - Install `bundler`, `ruby-2.2.2`, `sqlite3`
 - `bundle install`
 - Copy `config/database.yml.example` into `config/database.yml`
 - Copy `.env.example` into `.env`
 - `rake db:migrate`
 - `rackup ruby app.rb`
 - Navigate to `localhost:5000`

####Development Specific:
It's recommended to install EditorConfig for your editor to maintain consistent coding styles.

For ST3: https://packagecontrol.io/packages/EditorConfig
