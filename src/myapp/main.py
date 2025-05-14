"""Main module for the application."""

import sys


def add(a, b):
    """Add two numbers.
    
    Args:
        a: First number
        b: Second number
        
    Returns:
        Sum of a and b
    """
    return a + b


def main():
    """Run the main application."""
    print("Welcome to MyApp!")
    print(f"2 + 3 = {add(2, 3)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())