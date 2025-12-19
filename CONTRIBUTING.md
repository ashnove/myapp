# Contributing to MyApp

Thank you for your interest in contributing to MyApp! This document provides guidelines and instructions for contributing.

## Getting Started

### Prerequisites

- macOS 13.0 or later
- Xcode 15.0 or later
- Git
- Basic knowledge of Swift and SwiftUI

### Setup Development Environment

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/yourusername/myapp.git
   cd myapp
   ```

3. Open the project:
   ```bash
   cd MyApp
   open MyApp.xcodeproj
   ```

4. Build and run tests:
   - Press `Cmd + U` to run all tests
   - Ensure all tests pass before starting development

## Development Workflow

### 1. Create a Branch

Always create a new branch for your work:

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

**Branch naming conventions:**
- `feature/` - New features
- `fix/` - Bug fixes
- `refactor/` - Code refactoring
- `docs/` - Documentation changes
- `test/` - Test additions or modifications

### 2. Make Your Changes

Follow these guidelines:

#### Code Style

**Swift Style Guide:**
- Follow [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use 4 spaces for indentation
- Maximum line length: 120 characters
- Use meaningful variable names

**SwiftUI Conventions:**
```swift
// Good
struct ItemDetailView: View {
    @ObservedObject var item: Item
    @State private var isEditing = false
    
    var body: some View {
        // View code
    }
}

// Avoid
struct itemView: View {
    var i: Item
    var editing = false
}
```

**Comments:**
```swift
/// Brief description of the function
/// - Parameters:
///   - item: The item to process
///   - completion: Callback when processing completes
/// - Returns: Processing result
func processItem(_ item: Item, completion: @escaping (Result<Void, Error>) -> Void) {
    // Implementation
}
```

#### File Organization

- Place new views in `Views/`
- Place models in `Models/`
- Place services in `Services/`
- Place utilities in `Utilities/`
- Update tests accordingly

#### Core Data Changes

If modifying the data model:

1. Open `MyAppModel.xcdatamodeld`
2. Create a new version (Editor → Add Model Version)
3. Make your changes in the new version
4. Update entity classes
5. Test migration thoroughly

### 3. Write Tests

All new features must include tests:

**Unit Tests:**
```swift
func testNewFeature() throws {
    // Given
    let testData = createTestData()
    
    // When
    let result = performOperation(testData)
    
    // Then
    XCTAssertEqual(result, expectedValue)
}
```

**UI Tests:**
```swift
func testUserWorkflow() throws {
    // Given
    app.launch()
    
    // When
    app.buttons["Add"].tap()
    
    // Then
    XCTAssertTrue(app.staticTexts["Success"].exists)
}
```

**Test Coverage:**
- Aim for >80% code coverage
- Test edge cases
- Test error handling
- Test async operations

### 4. Run Tests

Before committing:

```bash
# Run all tests
xcodebuild test -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 15'

# Run specific tests
xcodebuild test -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:MyAppTests/MyAppTests/testItemCreation
```

Or in Xcode:
- `Cmd + U` - Run all tests
- Click test diamond next to specific test

### 5. Commit Your Changes

**Commit Message Format:**

```
type(scope): brief description

Detailed description of what changed and why.

- Bullet points for multiple changes
- Reference issues: #123
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build process or auxiliary tool changes

**Examples:**

```bash
git commit -m "feat(sync): add retry logic for failed syncs

Implements exponential backoff for failed sync operations.
Retries up to 3 times before marking as failed.

Fixes #42"
```

```bash
git commit -m "fix(ui): resolve navigation bar overlap issue

The navigation bar was overlapping content on smaller devices.
Adjusted spacing and safe area insets.

Closes #58"
```

### 6. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Create a pull request on GitHub with:

**PR Title:** Clear, concise description

**PR Description Template:**

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests added/updated
- [ ] UI tests added/updated
- [ ] Manual testing completed
- [ ] All tests pass

## Screenshots (if applicable)
[Add screenshots]

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings
- [ ] Tests added/updated

## Related Issues
Closes #issue_number
```

## Code Review Process

### What to Expect

1. **Automated Checks:** CI/CD runs tests and linting
2. **Peer Review:** At least one approval required
3. **Feedback:** Reviewers may request changes
4. **Iteration:** Address feedback, push updates
5. **Merge:** Once approved, maintainers will merge

### Responding to Feedback

- Be open to suggestions
- Ask questions if unclear
- Update code as requested
- Push additional commits to same branch
- Re-request review when ready

## Testing Guidelines

### Unit Testing

Test these aspects:
- ✅ Core Data operations
- ✅ Business logic
- ✅ Service methods
- ✅ Utility functions
- ✅ Error handling

### UI Testing

Test these workflows:
- ✅ User navigation
- ✅ Form submissions
- ✅ Error states
- ✅ Loading states
- ✅ Edge cases

### Performance Testing

Consider testing:
- App launch time
- View rendering speed
- Large dataset handling
- Memory usage

## Documentation

### Code Documentation

Use Swift doc comments:

```swift
/// Fetches items from the server
/// - Parameter completion: Called with result when fetch completes
/// - Throws: NetworkError if request fails
func fetchItems(completion: @escaping (Result<[Item], Error>) -> Void) throws {
    // Implementation
}
```

### README Updates

Update `README.md` when:
- Adding new features
- Changing setup process
- Modifying requirements
- Adding dependencies

### Architecture Documentation

Update `ARCHITECTURE.md` when:
- Adding new layers
- Changing data flow
- Modifying patterns
- Adding major components

## Common Tasks

### Adding a New View

1. Create `YourView.swift` in `Views/`
2. Implement SwiftUI view
3. Add preview provider
4. Connect to navigation
5. Add UI tests

### Adding a New Service

1. Create `YourService.swift` in `Services/`
2. Define protocol
3. Implement service class
4. Add to DI container (if applicable)
5. Add unit tests

### Adding Dependencies

Avoid adding unnecessary dependencies. If needed:

1. Add to `Package.swift`
2. Update `README.md` with new requirement
3. Justify in PR description

## Getting Help

### Resources

- [README.md](README.md) - Getting started
- [ARCHITECTURE.md](ARCHITECTURE.md) - Architecture details
- [Swift Documentation](https://docs.swift.org)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)

### Communication

- **Issues:** Bug reports, feature requests
- **Discussions:** Questions, ideas
- **Pull Requests:** Code contributions

## Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- Project website (if applicable)

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

Thank you for contributing to MyApp! 🎉
