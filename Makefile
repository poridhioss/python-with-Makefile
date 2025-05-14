# Minimal but Effective Makefile for Python Development

# Variables
PYTHON := python3
VENV := venv
VENV_BIN := $(VENV)/bin
PACKAGE_NAME := myapp
SRC_DIR := src
TEST_DIR := tests

# Timestamp markers instead of .PHONY
VENV_MARKER := $(VENV)/.installed
DEPS_MARKER := $(VENV)/.deps_installed
DEV_MARKER := $(VENV)/.dev_installed
TEST_MARKER := .test_timestamp

# Set up virtual environment
$(VENV_MARKER):
	@echo "Creating virtual environment..."
	@$(PYTHON) -m venv $(VENV)
	@touch $(VENV_MARKER)
	@echo "Virtual environment created"

# Install dependencies
$(DEPS_MARKER): requirements.txt $(VENV_MARKER)
	@echo "Installing dependencies..."
	@$(VENV_BIN)/pip install --upgrade pip
	@$(VENV_BIN)/pip install -r requirements.txt
	@$(VENV_BIN)/pip install pytest flake8
	@touch $(DEPS_MARKER)
	@echo "Dependencies installed"

# Setup development environment
setup: $(DEPS_MARKER)
	@echo "Development setup complete"

# Run tests with timestamp to avoid unnecessary reruns
$(TEST_MARKER): $(shell find $(SRC_DIR) $(TEST_DIR) -name "*.py" 2>/dev/null || echo "") $(DEV_MARKER)
	@echo "Running tests..."
	@PYTHONPATH=$(SRC_DIR) $(VENV_BIN)/pytest $(TEST_DIR)
	@touch $(TEST_MARKER)
	@echo "Tests complete"

# Run tests (public target)
test: $(DEV_MARKER) $(TEST_MARKER)

# Run linting
lint: $(DEPS_MARKER)
	@echo "Running linter..."
	@$(VENV_BIN)/flake8 $(SRC_DIR) $(TEST_DIR)
	@echo "Linting complete"

# Run the application
run: $(DEPS_MARKER) develop
	@echo "Running application..."
	@cd $(shell pwd) && $(VENV_BIN)/python -c "from myapp.main import main; main()"
	@echo "Application execution complete"

# Install in development mode
$(DEV_MARKER): $(DEPS_MARKER) setup.py
	@echo "Installing package in development mode..."
	@$(VENV_BIN)/pip install -e .
	@touch $(DEV_MARKER)
	@echo "Development installation complete"

# Develop target (public)
develop: $(DEV_MARKER)

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
	@rm -f $(TEST_MARKER)
	@echo "Test artifacts cleaned"

# Clean all
clean: clean-pyc clean-build clean-test
	@echo "Clean complete"

# Full reset (use with caution)
clean-all: clean
	@echo "Removing virtual environment..."
	@rm -rf $(VENV)
	@rm -f $(VENV_MARKER)
	@rm -f $(DEPS_MARKER)
	@rm -f $(DEV_MARKER)
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