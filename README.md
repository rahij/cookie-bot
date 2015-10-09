####Setup Instructions:

This is built on Sinatra

 - Clone the repo
 - Install `bundler`, `ruby-2.2.2`, `sqlite3` and `rerun`
 - `bundle install`
 - Copy `config/database.yml.example` into `config/database.yml`
 - Copy `.env.example` into `.env`
 - `rake db:migrate`
 - `rerun ruby app.rb`
 - Navigate to `localhost:4000`

####Development Specific:
It's recommended to install EditorConfig for your editor to maintain consistent coding styles.

For ST3: https://packagecontrol.io/packages/EditorConfig
