import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            searchBar
            Group {
                if viewModel.showingWeather {
                    weatherView
                } else if !viewModel.hasSearched {
                    welcomeView
                } else if viewModel.searchResults.isEmpty && !viewModel.isSearching {
                    noResultsView
                } else {
                    searchResultsView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.white)
        .overlay(
            errorView,
            alignment: .bottom
        )
    }
}

extension ContentView {
    
    private var searchBar: some View {
        VStack {
            TextField("City", text: $viewModel.city)
                .textFieldStyle(.plain)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                )
                .padding(.horizontal, 5)
                .onSubmit {
                    Task {
                        await viewModel.searchLocations()
                    }
                }
        }
        .padding()
    }
    
    private var welcomeView: some View {
        VStack(spacing: 20) {
            Image(systemName: "cloud.sun.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Welcome to Weather App")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Enter a city name above to get the current weather")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
    
    private var noResultsView: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No locations found")
                .font(.title2)
                .fontWeight(.medium)
            
            Text("Try searching for a different city")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
    }
    
    private var searchResultsView: some View {
        List(viewModel.searchResults) { location in
            Button(action: {
                Task {
                    await viewModel.selectLocation(location)
                }
            }) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(location.displayName)
                            .font(.headline)
                        Text("Lat: \(String(format: "%.2f", location.latitude)), Lon: \(String(format: "%.2f", location.longitude))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .listStyle(PlainListStyle())
    }
    
    private var weatherView: some View {
        VStack(spacing: 20) {
            if viewModel.isFetchingWeather {
                ProgressView("Loading weather...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let response = viewModel.weather, let location = viewModel.selectedLocation {
                WeatherView(location: location, weatherResponse: response, hourlyForecasts: viewModel.hourlyForecasts)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private var errorView: some View {
        Group {
            if viewModel.hasError {
                VStack {
                    Text("Error")
                        .font(.headline)
                        .foregroundColor(.red)
                    Text(viewModel.errorMessage ?? "Unknown error")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    Button("Dismiss") {
                        viewModel.clearError()
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
