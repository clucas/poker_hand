# README

This README would normally document whatever steps are necessary to get the
application up and running.
 
# Technology
 - Ruby 2.7.2
 - Rails 6.1.3
 - PostgreSQL 13.2 
 - Docker 20.10.x, Docker Compose 1.27.x
 
# Application
A running version is deployed with containers on heroku: https://intense-lake-36228.herokuapp.com
  - The web container is running on port 3000
  - The database is running on port 3432 

# Local installation instructions
 - Run
 ```Bash
./init.sh
 ```
 - Open http://localhost:3000
 
 # running tests
 ```Bash
docker-compose exec web rake spec 
```

## Create a game
Go to /games/new and import the text file, visualize the results on the game page.
IMPORTANT: The import request may timeout at 30 seconcds (This is a Heroku limitation), the page will display an error but reloading the page will allow you to veisualize the game imported from the poker.txt file.