# NewsApp

NewsApp is an iOS application built using SwiftUI and Combine. It fetches and displays news articles based on user preferences, with features for onboarding, viewing headlines, searching articles, and saving favorites. The app follows clean architecture principles with a focus on modularization and dependency injection.

## Features

- **Onboarding**: Select favorite country and categories.
- **Headlines**: View news headlines by country and category.
- **Search**: Search for articles by keywords.
- **Saved Articles**: Bookmark and view favorite articles.
- **Localization**: Supports Arabic localization.
- **Offline Caching**: Uses Realm for offline data storage.

## Architecture

The app follows a clean architecture with the following layers:
- **Presentation**: SwiftUI views and view models.
- **Domain**: Entities and use cases.
- **Data**: Repositories and data sources (local and remote).

## Project Structure

![App Structure](https://github.com/amr0010/NewsApp/assets/13542092/392a396b-4ca3-4b14-814b-9bef7777297f)

## Result

https://github.com/amr0010/NewsApp/assets/13542092/339cab69-e968-4a70-8438-da374bb300b4

## Usage

- Run the app on a simulator or a real device.
- Follow the onboarding process to select your favorite country and categories.
- Browse headlines, search for articles, and save your favorites.

## Dependencies

- [SwiftUI](https://developer.apple.com/documentation/swiftui/)
- [Combine](https://developer.apple.com/documentation/combine/)
- [Realm](https://realm.io/docs/swift/latest/)
- [Kingfisher](https://github.com/onevcat/Kingfisher)

