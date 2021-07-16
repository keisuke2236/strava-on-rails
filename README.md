## Ride on Develop
```
git clone git@github.com:keisuke2236/strava-on-rails.git
cd strava-on-rails
docker-compose run web rails new . --force --no-deps --database=postgresql
docker-compose build
docker-compose run web rake db:create
docker-compose up
```

ready to develop
http://localhost:3000

