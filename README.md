# 🌤️ WeatherApp

A modern, feature-rich weather application built with SwiftUI that provides real-time weather information, hourly forecasts, and location-based weather data. This project demonstrates advanced iOS development practices, clean architecture, and comprehensive testing strategies.


## 📱 Features

- **🌍 Location Search**: Search for cities worldwide with real-time geocoding
- **🌤️ Current Weather**: Display current temperature, humidity, wind speed, and visibility
- **⏰ Hourly Forecast**: 5-day hourly weather forecasts with detailed information
- **🎨 Modern UI**: Clean, intuitive interface with smooth animations
- **📱 Responsive Design**: Optimized for all iOS devices
- **⚡ Real-time Updates**: Live weather data from OpenWeatherMap API

## 🏗️ Architecture & Design Patterns

### MVVM Architecture
- **Model**: Data structures for weather, location, and forecast information
- **View**: SwiftUI views with reactive UI updates
- **ViewModel**: Business logic and state management with `@MainActor` concurrency

### Clean Architecture Principles
- **Separation of Concerns**: Clear boundaries between layers
- **Dependency Injection**: Modular and testable components
- **Single Responsibility**: Each class has a focused purpose
- **Interface Segregation**: Clean API contracts between layers

### Concurrency & Async/Await
- **Modern Swift Concurrency**: Full utilization of async/await patterns
- **Actor Isolation**: Proper handling of `@MainActor` properties
- **Background Processing**: Non-blocking UI with concurrent operations

## 🛠️ Technologies & Frameworks

### Core Technologies
- **Swift 5.9+**: Modern Swift with latest language features
- **SwiftUI 5.0+**: Declarative UI framework
- **iOS 18.5+**: Latest iOS platform features
- **Xcode 16.0+**: Latest development environment

### Networking & APIs
- **OpenWeatherMap API**: Weather data and geocoding services
- **URLSession**: Native networking with async/await
- **JSON Decoding**: Codable protocol for type-safe data parsing
- **Environment Variables**: Secure API key management


## 📁 Project Structure

```
WeatherApp/
├── WeatherApp/
│   ├── Views/                 # SwiftUI Views
│   │   ├── ContentView.swift
│   │   ├── WeatherView.swift
│   │   └── HourlyForecastView.swift
│   ├── ViewModels/           # MVVM ViewModels
│   │   └── WeatherViewModel.swift
│   ├── Models/               # Data Models
│   │   ├── Location.swift
│   │   ├── Main.swift
│   │   └── HourlyForecast.swift
│   ├── Clients/              # Network Layer
│   │   ├── WeatherClient.swift
│   │   ├── GeocodingClient.swift
│   │   └── APIEndpoint.swift
│   ├── Utilities/            # Helper Classes
│   │   ├── Constants.swift
│   │   └── Extensions/
│   └── Assets.xcassets/      # App Resources
├── WeatherAppTests/          # Unit & Integration Tests
│   ├── WeatherViewModelTests.swift
│   ├── NetworkClientTests.swift
│   ├── ModelTests.swift
│   ├── IntegrationTests.swift
│   └── WeatherAppTests.swift
├── WeatherAppUITests/        # UI Tests
    └── WeatherAppUITests.swift

```

## 🚀 Getting Started

### Prerequisites
- Xcode 16.0 or later
- iOS 18.5+ deployment target
- OpenWeatherMap API key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/WeatherApp.git
   cd WeatherApp
   ```

2. **Open in Xcode**
   ```bash
   open WeatherApp.xcodeproj
   ```

3. **Configure API Key**
   - Create a `.env` file in the project root
   - Add your OpenWeatherMap API key:
     ```
     WEATHER_API_KEY=your_api_key_here
     ```

4. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run

### Running Tests

```bash
# Run all tests
xcodebuild test -scheme WeatherApp -destination 'platform=iOS Simulator,name=iPhone 16'

# Run specific test suite
xcodebuild test -scheme WeatherApp -only-testing:WeatherAppTests

# Run UI tests
xcodebuild test -scheme WeatherApp -only-testing:WeatherAppUITests
```

## 🧪 Testing Strategy

### Test Categories
- **Unit Tests**: Individual component testing
- **Integration Tests**: End-to-end workflow validation
- **UI Tests**: Automated user interface testing
- **Performance Tests**: Network and UI performance validation

### Test Coverage
- **ViewModel Logic**: 100% coverage of business logic
- **Network Layer**: Complete API testing with error scenarios
- **Data Models**: Validation and edge case testing
- **User Flows**: Complete user journey testing

## 🎯 Key Features Implementation

### Real-time Weather Data
- Async/await network calls for responsive UI
- Automatic data refresh and caching
- Error handling with user-friendly messages

### Location Services
- Geocoding with OpenWeatherMap API
- Search validation and auto-complete
- Support for international cities and special characters

### Modern UI/UX
- SwiftUI declarative interface
- Smooth animations and transitions
- Accessibility support
- Dark mode compatibility

## 📊 Performance & Optimization

### Network Optimization
- Efficient API calls with proper caching
- Background processing for non-blocking UI
- Error handling and retry mechanisms

### Memory Management
- Proper use of SwiftUI lifecycle
- Efficient data structures
- Automatic memory cleanup

### UI Performance
- Lazy loading for forecast data
- Optimized view updates
- Smooth scrolling and animations

## 🔒 Security & Best Practices

### API Security
- Environment variable configuration
- Secure API key management
- Input validation and sanitization

### Code Quality
- Comprehensive error handling
- Input validation and edge case coverage
- Clean, readable, and maintainable code
- Consistent coding standards


## 🙏 Acknowledgments

- **OpenWeatherMap**: Weather data and geocoding services
