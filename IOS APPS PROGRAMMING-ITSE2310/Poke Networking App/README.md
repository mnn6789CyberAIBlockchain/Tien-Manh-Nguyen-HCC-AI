# Poke Networking App

A SwiftUI iOS application that allows users to search for Pokémon by entering a Pokémon number and retrieving live data from the PokéAPI.

This project was created as the Final Project for the iOS Application Programming course at Houston Community College (HCC).

---

# Features

* SwiftUI user interface
* Networking with REST API
* Async/Await API calls
* JSON decoding using Codable
* MVVM-inspired architecture
* Dynamic Pokémon image loading
* Loading, Error, Start, and Loaded states
* Displays Pokémon:

  * Name
  * Image
  * Abilities
  * Moves

---

# Technologies Used

* Swift
* SwiftUI
* Xcode
* URLSession
* Async/Await
* Codable
* PokéAPI

---

# App Preview

## Main Features

Users can:

1. Enter a Pokémon number
2. Fetch Pokémon information from the internet
3. View Pokémon details dynamically
4. Experience loading and error handling states

Example Pokémon numbers:

```text
1
25
6
150
```

---

# Project Structure

```text
PokeNetworkingApp
│
├── Models
│   ├── Pokemon.swift
│   └── Pokemon+SampleData.swift
│
├── Networking
│   ├── NetworkManager.swift
│   └── NetworkError.swift
│
├── Views
│   ├── ContentView
│   │   ├── ContentView.swift
│   │   ├── ContentView+Helpers.swift
│   │   ├── ContentViewModel.swift
│   │   ├── EntryView.swift
│   │   ├── StateView+Error.swift
│   │   ├── StateView+Loaded.swift
│   │   ├── StateView+Loading.swift
│   │   └── StateView+Start.swift
│   │
│   └── PokemonView
│       ├── PokemonView.swift
│       └── PokemonViewModel.swift
│
└── Assets.xcassets
```

---

# Networking

The app uses the public PokéAPI:

[https://pokeapi.co/api/v2/pokemon/](https://pokeapi.co/api/v2/pokemon/)

Example endpoint:

```text
https://pokeapi.co/api/v2/pokemon/25
```

The app retrieves:

* Pokémon name
* Pokémon image
* Pokémon abilities
* Pokémon moves

---

# How To Run

## Requirements

* macOS
* Xcode 15+
* iOS Simulator or physical iPhone

## Steps

1. Clone the repository

```bash
git clone <GITHUB_REPO_LINK>
```

2. Open the project in Xcode

3. Run the app using:

```text
⌘ + R
```

4. Enter a Pokémon number and tap:

```text
Get a Pokemon
```

---

# Learning Objectives Demonstrated

This project demonstrates:

* SwiftUI layouts and views
* State management
* MVVM architecture concepts
* Networking with APIs
* Async programming with async/await
* JSON parsing and Codable
* Image downloading from URLs
* Error handling
* Dynamic UI updates

---

# Demo Video



---

# Future Improvements

Possible future improvements:

* Search Pokémon by name
* Add Pokémon types and stats
* Add animations
* Add favorite Pokémon saving
* Add dark mode customization
* Add sound effects and transitions

---

# Author

Tien Manh Nguyen

Houston Community College (HCC)

ITSE-2310 — iOS Application Programming

Spring 2026
