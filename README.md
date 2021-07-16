## Ride on Develop
```
git clone git@github.com:keisuke2236/strava-on-rails.git
cd strava-on-rails
docker-compose run web rails new . --force --no-deps --database=postgresql
docker-compose build
docker-compose run web rake db:create
docker-compose up -d
docker-compose exec web bash
bundle install
rails s -b 0.0.0.0
```

ready to develop
http://localhost:3000

