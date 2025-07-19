import Foundation
import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var weather: WeatherResponse?
    @Published var selectedLocation: Location?
    @Published var searchResults: [Location] = []
    @Published var isSearching: Bool = false
    @Published var isFetchingWeather: Bool = false
    @Published var hasSearched: Bool = false
    @Published var errorMessage: String?
    @Published var showingWeather: Bool = false
    @Published var hourlyForecasts: [HourlyForecast] = []
    
    private let geocodingClient = GeocodingClient()
    private let weatherClient = WeatherClient()
    
    var hasError: Bool {
        errorMessage != nil
    }
    
    func searchLocations() async {
        let trimmedCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedCity.isEmpty else { 
            errorMessage = "Please enter a city name"
            return 
        }
        
        isSearching = true
        hasSearched = true
        errorMessage = nil
        showingWeather = false
        
        do {
            let results = try await geocodingClient.searchLocations(trimmedCity)
            searchResults = results
        } catch {
            errorMessage = error.localizedDescription
            searchResults = []
        }
        
        isSearching = false
    }
    
    func selectLocation(_ location: Location) async {
        isFetchingWeather = true
        errorMessage = nil
        selectedLocation = location
        
        do {
            async let weatherTask = weatherClient.fetchWeather(location: location)
            async let hourlyTask = weatherClient.fetchHourlyForecast(location: location)
            
            let (weatherResult, hourlyResult) = try await (weatherTask, hourlyTask)
            
            weather = weatherResult
            hourlyForecasts = hourlyResult
            showingWeather = true
            searchResults = []
            city = ""
        } catch {
            errorMessage = error.localizedDescription
            hourlyForecasts = []
        }
        
        isFetchingWeather = false
    }
    
    func resetSearch() {
        city = ""
        weather = nil
        searchResults = []
        hasSearched = false
        showingWeather = false
        errorMessage = nil
        hourlyForecasts = []
        selectedLocation = nil
    }
    
    func clearError() {
        errorMessage = nil
    }
} 
