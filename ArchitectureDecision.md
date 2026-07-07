# Architecture Decision Document

## Sporty iOS Coding Challenge - GitHub Repository Application


# 1. Overview

The goal of this implementation was to refactor the existing application into a clean, maintainable, and testable architecture.

The main objectives were:

- Separate UI, business logic, and networking responsibilities
- Improve code readability and maintainability
- Make unit testing easier
- Reduce dependency between components
- Allow future features to be added without large changes
- Follow SOLID principles and modern Swift practices


---

# 2. Architecture Pattern - MVVM


## Decision

The application uses the MVVM (Model-View-ViewModel) architecture pattern.


## Why MVVM?

MVVM was chosen because it separates UI code from business logic.

The ViewController is responsible only for displaying the UI, while the ViewModel manages the screen state and communicates with the service layer.

This makes the code easier to maintain and test.


---

## ViewController Responsibility

The ViewController is responsible for:

- Displaying repository list
- Updating UI based on ViewModel changes
- Handling user interactions
- Managing table view


The ViewController does not:

- Call APIs directly
- Contain business logic
- Create service objects


---

## ViewModel Responsibility

The ViewModel is responsible for:

- Loading repository data
- Managing loading state
- Handling errors
- Providing data for UI


The ViewModel does not know about:

- UIKit
- ViewController
- GitHubAPI


This makes the ViewModel easy to test.


---

## Service Layer Responsibility

The service layer is responsible for:

- Fetching repository data
- Communicating with GitHub API
- Hiding networking details from ViewModel


The ViewModel only depends on protocols, not concrete networking classes.


---

# 3. Dependency Injection


## Decision

Initializer-based Dependency Injection is used.


Example:

```swift
RepositoriesViewModel(
    repositoryService: repositoryService
)


# AI Usage

AI tools were used as a support during development for:

- Reviewing architecture decisions and improving code structure
- Getting suggestions for MVVM, dependency injection, and SOLID principles
- Reviewing possible improvements for readability and maintainability
- Helping identify edge cases and testing considerations

All final implementation decisions, code changes, and architectural choices were reviewed and adapted based on the project requirements.
