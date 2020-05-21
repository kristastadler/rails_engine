# Rails Engine

Rails Engine is an API that leverages the data from the Sales Engine to power a front end application called Rails Driver.

Rails Driver displays merchants and items from Sales Engine, as well as business analytics related to merchant revenue.

## How to Clone Project to Local Machine
Use the instructions below in combination with your terminal in order to learn more about this project:

  1. Clone this repository:
    ```https://github.com/kristastadler/rails_engine```

  2. Install the necessary gems:
    ```bundle install``` &
    ```bundle update```

  3. Initialize the database:
    ```rails db:{create,migrate}```

  4. Seed the database:
    ```rake db:seed:from_csv```

  5. Clone and set up Rails Driver:
    ```https://github.com/turingschool-examples/rails_driver```

  6. Make a connection to Rails Engine with the Rails server:
    ```rails s```

  7. Make a connection to Rails Driver with the Rails server:  
    ```rails s -p 3001```

  8. Visit your browser, and enter the following into the search bar:
  ```localhost:3001```

  9. Enjoy!

## Skills Gained from this Project

### APIs & ActiveRecord
* Expose an API.
* Use serializers to format json responses
* Test API exposure
* Compose advanced ActiveRecord queries to analyze information stored in SQL databases.


### Testing and Debugging
* Write feature tests utilizing:
  - RSpec and Capybara
  - CSS selectors to target specific areas of a page
  - Utilize the Rails console as a tool to get more information about the current state of a development database
