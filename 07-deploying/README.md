# Phase-2-Deploying 

## SWBAT
- [ ] Understand what "deploying" means
- [ ] Deploy to Heroku
- [ ] Seed and Migrate on Heroku
- [ ] Push updates to Heroku


### Heroku 
Heroku is a Platform as a Service (PaaS). It manages the hardware and environment we can use to host our application. Instead of hosting it locally we can use Heroku's service to host our app on the web.

### Download Heroku 

```
 brew tap heroku/brew && brew install heroku

 # Using the terminal log into heroku 
  heroku login

```
Heroku only supports specific versions of ruby. Of the versions it supports we recommend 2.7.4

```
 rvm install 2.7.4 --default
 gem install bundler
 gem install rails

```

Heroku requires Postgresql instead if SQLight

```
brew install postgresql

brew services start postgresql


```

### How to host a rails

To deploy a rails/react app we need to make sure the app is using postgresql 

```
 rails new flatiron-theater --api --minimal --database=postgresql

# This will configure our gemfile.lock to work with the same OS Heroku uses 
 bundle lock --add-platform x86_64-linux --add-platform ruby

#Build the app as normal 
```

### Hosting React


To host our react app in the same domain as our rails app we will need to configure react to work in rails production.

```
 npm install --prefix client

# Create a Procfile in the root of your directory
web: bundle exec rails s
release: bin/rake db:migrate

# Create a Procfile.dev in the root of your directory as well
# This will allow you to run your app locally using heroku
web: PORT=4000 npm start --prefix client
api: PORT=3000 bundle exec rails s


 # Create a static React APP that is being served from rails
 npm run build --prefix client

 # Move the static files to public which is used by rails to server static assets 
  mv client/build/* public

# Configure client side routing
# Because we use client side routing we need to make sure the routes from our react app sill loads our components. 
# this will redirect routes client to our index.html 
# route.rb
  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }

# terminal 
  rails g controller fallback_controller

# app/controllers/fallback_controller.rb
class FallbackController < ActionController::Base
  def index
    render file: 'public/index.html'
  end
end


```

## Deploy to Heroku 

``` 
# Add a package.json to the root of your rails app
```
{
    "name": "heroku-deploy",
    "description": "Build scripts for Heroku",
    "engines": {
      "node": "15.6.0"
    },
    "scripts": {
      "clean": "rm -rf public",
      "build": "npm install --prefix client && npm run build --prefix client",
      "deploy": "cp -a client/build/. public/",
      "heroku-postbuild": "npm run clean && npm run build && npm run deploy"
    }
  }


```


heroku create

git add .
git commit -m 'Initial commit'


heroku buildpacks:add heroku/nodejs --index 1
heroku buildpacks:add heroku/ruby --index 2

git push heroku main

# seed and migrate
 heroku run rails db:migrate db:seed

#open your heroku app 
heroku open

# See the url that your app is being hosted at
git config --list --local | grep heroku


# run heroku locally
 heroku local -f Procfile.dev

```


