# Makefile for MyApp

.PHONY: help build test clean run lint format archive

# Default target
help:
	@echo "MyApp - iOS Application"
	@echo ""
	@echo "Available targets:"
	@echo "  build     - Build the app"
	@echo "  test      - Run all tests"
	@echo "  clean     - Clean build artifacts"
	@echo "  run       - Build and run on simulator"
	@echo "  lint      - Run SwiftLint"
	@echo "  format    - Format code with SwiftFormat"
	@echo "  archive   - Create archive for distribution"

# Build the app
build:
	@echo "Building MyApp..."
	xcodebuild build \
		-project MyApp/MyApp.xcodeproj \
		-scheme MyApp \
		-destination 'platform=iOS Simulator,name=iPhone 15' \
		-configuration Debug

# Run tests
test:
	@echo "Running tests..."
	xcodebuild test \
		-project MyApp/MyApp.xcodeproj \
		-scheme MyApp \
		-destination 'platform=iOS Simulator,name=iPhone 15' \
		-configuration Debug

# Clean build artifacts
clean:
	@echo "Cleaning..."
	xcodebuild clean \
		-project MyApp/MyApp.xcodeproj \
		-scheme MyApp
	rm -rf MyApp/build
	rm -rf MyApp/DerivedData

# Build and run on simulator
run: build
	@echo "Running on simulator..."
	xcrun simctl install booted MyApp/build/Debug-iphonesimulator/MyApp.app
	xcrun simctl launch booted com.myapp.MyApp

# Run SwiftLint
lint:
	@echo "Running SwiftLint..."
	@if command -v swiftlint > /dev/null; then \
		swiftlint lint --config .swiftlint.yml; \
	else \
		echo "SwiftLint not installed. Install with: brew install swiftlint"; \
	fi

# Format code
format:
	@echo "Formatting code..."
	@if command -v swiftformat > /dev/null; then \
		swiftformat MyApp/MyApp --config .swiftformat; \
	else \
		echo "SwiftFormat not installed. Install with: brew install swiftformat"; \
	fi

# Create archive
archive:
	@echo "Creating archive..."
	xcodebuild archive \
		-project MyApp/MyApp.xcodeproj \
		-scheme MyApp \
		-archivePath MyApp/build/MyApp.xcarchive

# Install dependencies (if using CocoaPods or similar)
install:
	@echo "No package manager dependencies to install"
	@echo "The project uses Xcode project with no external dependencies"
