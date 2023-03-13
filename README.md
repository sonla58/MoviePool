## MoviePool

A small application to search for movies via OMDB API.
This is a small project to learn more about SwiftUI and Combine.
Architecture is also a big part of this project (in the future =))).

![Screenshot](Res/movie.GIF)

## Installation

### Requirements

- Xcode 14.2
- iOS 16

### Setup

1. Clone the repository
2. Run script `./getting_start.sh` and put your OMDB API key
3. Open the project in Xcode
4. Run the project

## Structure

### MVVM

This project uses the new approach for building MVVM architecture in SwiftUI.
The main idea is to use a `View` acting as a `ViewModel` and another `View` acting as a `View`.

❓ Why?

Updating... I will write about it soon. 🥱

## Todo

- [ ] OMDB service should be communicating with the application layer in Respository pattern
- [ ] Injections should be done via Dependency Injection
- [ ] Optimize the loading of the images in the list of results
- [ ] Support multiple platforms (macOS, tvOS)
