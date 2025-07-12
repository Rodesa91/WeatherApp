import SwiftUI

struct ContentView: View {
    @State private var city: String = ""
    @State private var isFeatchingWeather: Bool = false
    @State private var weather: Weather?
    
    let geocodingClient = GeocodingClient()
    let weatherClient = WeatherClient()
    
    
    
    var body: some View {
        VStack {
            TextField("City", text: $city)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    isFeatchingWeather = true
                }.task(id: isFeatchingWeather) {
                    if isFeatchingWeather {
                        await featchWeather()
                        isFeatchingWeather = false
                        city = ""
                    }
                }
            Spacer()
            if let weather = weather {
                Text(MeasurementFormatter.temperature(value: weather.temp))
                    .font(.system(size: 100))
            }
            Spacer()
        }
        .padding()
    }
    
    private func featchWeather() async {
        do {
            guard let location = try await geocodingClient.coordinateByCity(city) else { return }
            weather = try await weatherClient.fetchWeather(location: location)
        } catch {
            print(error)
        }
    }
}

#Preview {
    ContentView()
}
