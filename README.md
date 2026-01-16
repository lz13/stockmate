# StockMate

A Ruby on Rails application for stock management and inventory tracking.

## About
StockMate is designed to help businesses manage their inventory efficiently with features for:
- Stock tracking
- Inventory management
- [other key features here]

## Ruby Version

* ruby-3.2.2
* Rails 7.2.3

## System Dependencies

* psql (PostgreSQL) 17.5 (Postgres.app)
* Node v20.19.0
* Yarn 1.22.22

## Setup

### Initial Setup

1. Clone the repository
    ```bash
   git clone git@github.com:lz13/stockmate.git
   cd stockmate
    ```
   
2. Install dependencies
    ```bash
    bundle install
    yarn install
    ```
   
3. Set up the database
    ```bash
    bin/rails db:create
    bin/rails db:migrate
    bin/rails db:seed
    ```
   
### Configuration

Copy the example environment file and configure your settings:
```bash
cp .env.example .env
```

## How to Run the Test Suite

### Running Tests

```bash
bundle exec rspec

# Run a specific test file
bundle exec rspec spec/models/your_model_spec.rb

# Run with coverage
COVERAGE=true bundle exec rspec
```

### Code Quality
```bash
# Run RuboCop linting
bundle exec rubocop

# Auto-fix RuboCop offenses
bundle exec rubocop -A
```

## Development

### Starting the Server
```bash
bin/rails server
```
The application will be available at `http://localhost:3000`.

### Useful Commands
```bash
# Reset database
bin/rails db:drop db:create db:migrate db:seed

# Generate new migration
bin/rails generate migration MigrationName

# Rails console
bin/rails console
```

### Testing Environment

This project uses:

* **RSpec** for testing framework
* **DatabaseCleaner** for test isolation
* **RuboCop** for code linting and style enforcement
* **Awesome Print** for debugging

## Deployment

Instructions for deploying will go here.

## Contributing
1. Create a feature/fix branch from `develop`
2. Make your changes
3. Run tests and linting
4. Create a pull request to `develop`

## License
[Specify your license here]