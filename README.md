####Setup Instructions:

This is built on Sinatra

 - Clone the repo
 - Install `bundler`, `ruby-2.2.2`, `sqlite3`
 - Copy `config/database.yml.example` into `config/database.yml`
 - Copy `.env.example` into `.env`
 - `bundle install`
 - `rake db:migrate`
 - `rerun 'rackup -p 5000'`
 - Navigate to `localhost:5000`

####Development Specific:
It's recommended to install EditorConfig for your editor to maintain consistent coding styles.

For ST3: https://packagecontrol.io/packages/EditorConfig
