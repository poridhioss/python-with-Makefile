"""Tests for the main module."""

from myapp.main import add, main


def test_add():
    """Test the add function."""
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
    assert add(0, 0) == 0


def test_main():
    """Test the main function."""
    # Simple test to ensure main function runs
    assert main() == 0