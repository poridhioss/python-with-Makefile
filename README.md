# Quick Start Guide: Python Project Setup

This guide walks you through setting up and running the Python project with our minimal but effective development environment.

## Prerequisites

First, ensure Python and the virtual environment package are installed:

```bash
apt update
apt install python3.8-venv
```

## Development Setup

The project uses a Makefile to streamline development tasks. Follow these simple steps to get started:

### 1. Set Up the Environment

Create a virtual environment and install dependencies:

```bash
make setup
```

This command:
- Creates a Python virtual environment in the `venv` directory
- Installs required packages from `requirements.txt`
- Installs development tools (pytest, flake8)

### 2. Install in Development Mode

Install the package in development mode to enable live code changes:

```bash
make develop
```

This command:
- Installs the package in editable mode using `pip install -e .`
- Allows you to modify code without reinstalling

### 3. Run the Application

Execute the main application:

```bash
make run
```

This command runs the main function from your application.

### 4. Run Tests

Execute the test suite:

```bash
make test
```

This command:
- Runs pytest to execute all tests in the `tests` directory
- Reports test results in the terminal

## Additional Commands

The Makefile includes other useful commands:

- `make lint` - Check code quality with flake8
- `make clean` - Remove temporary files and caches
- `make clean-all` - Completely reset the project environment
- `make help` - Display all available commands

## Project Structure

```
myapp/
├── Makefile              # Streamlines development tasks
├── requirements.txt      # Package dependencies
├── setup.py              # Package configuration
├── src/
│   └── myapp/            # Source code
│       ├── __init__.py
│       ├── __main__.py   # Entry point for module execution
│       └── main.py       # Main application code
└── tests/
    ├── __init__.py
    └── test_main.py      # Test cases
```