#!/usr/bin/env bash

# Combined Code Coverage for Flutter and Dart Projects
# Source: https://medium.com/@nocnoc/combined-code-coverage-for-flutter-and-dart-237b9563ecf8

# Exit on any error and capture errors
set -e
error=false

# Help message
show_help() {
  printf "Usage: $0 [--help]
Tool for running all unit and widget tests with code coverage and generating a report (if lcov is installed).

(run from the root of the repo)
Options:
    --help
        Show this help message and exit.
"
  exit 1
}

# Run code generation using build_runner
run_build_runner() {
  echo "Running build_runner for: $1"
  cd "$1"
  if grep -q build_runner pubspec.yaml >/dev/null; then
    flutter pub run build_runner build --delete-conflicting-outputs || error=true
  else
    echo "No build_runner dependency found, skipping code generation for: $1"
  fi
  cd - >/dev/null
}

# Run unit and widget tests
run_tests() {
  local module_dir=$1
  local project_root=$2

  cd "$module_dir"

  if [ -f "pubspec.yaml" ] && [ -d "test" ]; then
    echo "Running tests in: $module_dir"
    flutter pub get

    # Escape module path for lcov formatting
    local escaped_path
    escaped_path=$(echo "$module_dir" | sed 's/\//\\\//g')

    # Run tests with coverage
    if grep -q flutter pubspec.yaml; then
      echo "Running Flutter tests"
      if [ -f "test/all_tests.dart" ]; then
        flutter test --coverage test/all_tests.dart || error=true
      else
        flutter test --coverage || error=true
      fi

      # Combine coverage data if available
      if [ -d "coverage" ] && [ -f "coverage/lcov.info" ]; then
        echo "Merging coverage data from: $module_dir"
        sed "s/^SF:lib/SF:$escaped_path\/lib/g" coverage/lcov.info >>"$project_root/coverage/test.info"
        rm -f coverage/lcov.info
      fi
    else
      echo "Not a Flutter package, skipping: $module_dir"
    fi
  fi

  cd - >/dev/null
}

# Check if the script is run from the root of the repository
if ! [ -f "pubspec.yaml" ] && [ -d .git ]; then
  printf "\nError: Script must be run from the root of the repository.\n"
  show_help
fi

# Main logic
case $1 in
--help)
  show_help
  ;;
*)
  project_root=$(pwd)

  # Clean previous coverage data
  if [ -d "coverage" ]; then
    rm -rf coverage
  fi
  mkdir -p coverage

  # Run tests for all modules or a specific one
  if [ -z "$1" ]; then
    echo "Running tests for all modules..."
    modules=$(find . -maxdepth 2 -type d)
    for module in $modules; do
      run_tests "$module" "$project_root"
    done
  else
    if [ -d "$1" ]; then
      run_tests "$1" "$project_root"
    else
      printf "\nError: Not a valid directory: $1\n"
      show_help
    fi
  fi

  ;;
esac

# Exit with error if any test failed
if [ "$error" = true ]; then
  echo "Some tests failed."
  exit 1
fi
