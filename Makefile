# Variables
PYTHON := python3
VENV := venv
VENV_BIN := $(VENV)/bin
PACKAGE_NAME := myapp
SRC_DIR := src
TEST_DIR := tests

# Set up virtual environment
$(VENV)/bin/pip:
	@echo "Creating virtual environment..."
	@$(PYTHON) -m venv $(VENV)
	@echo "Virtual environment created"

# Install dependencies
setup: $(VENV)/bin/pip requirements.txt
	@echo "Installing dependencies..."
	@$(VENV_BIN)/pip install --upgrade pip
	@$(VENV_BIN)/pip install -r requirements.txt
	@$(VENV_BIN)/pip install pytest flake8
	@echo "Dependencies installed"

# Install in development mode
develop: setup setup.py
	@echo "Installing package in development mode..."
	@$(VENV_BIN)/pip install -e .
	@echo "Development installation complete"

# Run tests
test: develop
	@echo "Running tests..."
	@PYTHONPATH=$(SRC_DIR) $(VENV_BIN)/pytest $(TEST_DIR)
	@echo "Tests complete"

# Run linting
lint: setup
	@echo "Running linter..."
	@$(VENV_BIN)/flake8 $(SRC_DIR) $(TEST_DIR)
	@echo "Linting complete"

# Run the application
run: develop
	@echo "Running application..."
	@cd $(shell pwd) && $(VENV_BIN)/python -c "from $(PACKAGE_NAME).main import main; main()"
	@echo "Application execution complete"

# Clean Python bytecode files
clean-pyc:
	@echo "Cleaning Python compiled files and caches..."
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@find . -type f -name "*.pyc" -delete
	@find . -type f -name "*.pyo" -delete
	@find . -type f -name "*.pyd" -delete
	@echo "Python files cleaned"

# Clean build directories
clean-build:
	@echo "Cleaning build directories..."
	@rm -rf build/
	@rm -rf dist/
	@rm -rf *.egg-info
	@echo "Build directories cleaned"

# Clean test artifacts
clean-test:
	@echo "Cleaning test artifacts..."
	@rm -rf .pytest_cache
	@rm -rf .coverage
	@rm -rf htmlcov/
	@echo "Test artifacts cleaned"

# Clean all
clean: clean-pyc clean-build clean-test
	@echo "Clean complete"

# Full reset (use with caution)
clean-all: clean
	@echo "Removing virtual environment..."
	@rm -rf $(VENV)
	@echo "Project reset complete"

# Help
help:
	@echo "Available targets:"
	@echo "  setup     - Set up development environment"
	@echo "  test      - Run tests"
	@echo "  lint      - Run linter"
	@echo "  run       - Run the application"
	@echo "  develop   - Install in development mode"
	@echo "  clean     - Clean Python, build and test files"
	@echo "  clean-all - Complete reset including virtual env"
	@echo "  help      - Show this help message"
