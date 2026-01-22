# StockMate

A Ruby on Rails application for stock management and inventory tracking.

## Table of Contents
- [About](#about)
- [Features](#features)
- [Ruby Version](#ruby-version)
- [System Dependencies](#system-dependencies)
- [Setup](#setup)
  - [Initial Setup](#initial-setup)
  - [Configuration](#configuration)
- [How to Run the Test Suite](#how-to-run-the-test-suite)
  - [Running Tests](#running-tests)
  - [Code Quality](#code-quality)
- [Development](#development)
  - [Starting the Server](#starting-the-server)
  - [Useful Commands](#useful-commands)
  - [Testing Environment](#testing-environment)
- [Core Models](#core-models)
  - [Product](#product)
  - [StockMovement](#stockmovement)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)

## About

StockMate is designed to help businesses manage their inventory efficiently with features for:
- Product management
- Stock movement tracking (inbound, outbound, adjustments)
- Inventory level monitoring
- Comprehensive audit trails for stock changes

## Features

- User authentication (powered by Devise)
- Multi-language support (Croatian/English)
- Responsive design with Tailwind CSS
- Interactive components with Stimulus

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

# Sync `develop` with `main`
git checkout develop
git pull origin main
git push origin develop
```

### Testing Environment

This project uses:

* **RSpec** for testing framework
* **DatabaseCleaner** for test isolation
* **RuboCop** for code linting and style enforcement
* **Awesome Print** for debugging

## Deployment

Deployment steps will vary depending on your hosting provider (e.g., Render, Heroku, Fly.io, or a VPS). A typical production deployment involves:

1. Configure environment variables (database URL, `RAILS_MASTER_KEY`, `SECRET_KEY_BASE`, mailer settings, etc.) and set `RAILS_ENV=production`.
2. Ensure the production database is available and run migrations:
   ```bash
   bin/rails db:migrate RAILS_ENV=production
   
## Core Models

### Product
- UUID-based identification
- NAme and description fields
- Associated stock movements
- Automatic cleanup of related data on deletion

### StockMovement
- Tracks all inventory changes (inbound, outbound, adjustments)
- Links to specific products
- Records change amounts and reasons
- Timstamped for audit purposes

## Contributing
1. Create a feature/fix branch from `develop`
2. Make your changes
3. Run tests and linting
4. Create a pull request to `develop`

## License
This project is not currently licensed for public use. All rights reserved.