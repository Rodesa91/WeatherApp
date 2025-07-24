import SwiftUI

struct WeatherView: View {
    var location: Location
    var weatherResponse: WeatherResponse
    var hourlyForecasts: [HourlyForecast]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                cityNameView
                MainWeatherCard(weatherResponse: weatherResponse)
                HourlyForecastView(hourlyForecasts: hourlyForecasts)
                Spacer()
            }
            .padding()
        }
    }
}

extension WeatherView {
    var cityNameView: some View {
        Text(location.displayName)
            .font(.title)
            .bold()
            .padding(.top)
    }
}

#Preview {
    let houlryData = HourlyForecast.mockData

    WeatherView(location: .preview,
                weatherResponse: .preview,
                hourlyForecasts: houlryData)
}


struct MainWeatherCard: View {
    var weatherResponse: WeatherResponse
    
    var temp: String { String(format: "%.0f", weatherResponse.main.temp) }
    var minTemp: String { String(format: "%.0f", weatherResponse.main.minTemp) }
    var maxTemp: String { String(format: "%.0f", weatherResponse.main.maxTemp) }
    var feelsLike: String { String(format: "%.0f", weatherResponse.main.feelsLike) }
    var windSpeed: String { weatherResponse.wind.windSpeed }
    var humidity: String { "\(weatherResponse.main.humidity)%" }
    var visibility: String { weatherResponse.visibilityDescription }

    var body: some View {
        VStack(spacing: 16) {
            VStack {
            
                if let icon = weatherResponse.icon.first {
                    Image(systemName: icon.sfSymbolName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .padding(.top)
                }
                    
                Text(" \(temp)°")
                    .font(.system(size: 120, weight: .bold))
                    .foregroundColor(.white)
                
            }
            Text("Min: \(minTemp) -  Max: \(maxTemp)")
                            .font(.headline)
                            .foregroundColor(.white)
           
            HStack {
                WeatherInfoItem(title: "WIND", value: "\(windSpeed)", icon: "wind")
                WeatherInfoItem(title: "FEELS LIKE", value: "\(feelsLike)°", icon: "thermometer")
            }

            HStack {
                WeatherInfoItem(title: "VISIBILITY", value: visibility, icon: "eye")
                WeatherInfoItem(title: "HUMIDITY", value: humidity, icon: "humidity.fill")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(20)
    }
}


struct WeatherInfoItem: View {
    var title: String
    var value: String
    var icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white.opacity(0.8))
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                Text(value)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
