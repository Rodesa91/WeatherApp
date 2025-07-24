import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
    let visibility: Int
    let wind: Wind
    let icon: [IconInfomation]
    
    enum CodingKeys: String, CodingKey {
        case main
        case visibility
        case wind
        case icon = "weather"
    }
    
    var visibilityDescription: String {
        if visibility >= 10000 {
            return "10+ km"
        } else if visibility >= 1000 {
            let kilometers = Double(visibility) / 1000
            return String(format: "%.1f km", kilometers)
        } else {
            return "\(visibility) m"
        }
    }
}

extension WeatherResponse {
    static var preview: WeatherResponse {
        WeatherResponse(
            main: Weather(
                temp: 24.0,
                feelsLike: 25.0,
                humidity: 60,
                maxTemp: 32.0,
                minTemp: 24.0
            ),
            visibility: 2000,
            wind: Wind(speed: 19.2),
            icon: [
                IconInfomation(code: "10d")
            ]
        )
    }
}

struct IconInfomation: Decodable {
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case code = "icon"
    }
}

extension IconInfomation {
    var sfSymbolName: String {
        switch code {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.stars.fill"
        case "02d": return "cloud.sun.fill"
        case "02n": return "cloud.moon.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "smoke.fill"
        case "09d", "09n": return "cloud.drizzle.fill"
        case "10d", "10n": return "cloud.rain.fill"
        case "11d", "11n": return "cloud.bolt.fill"
        case "13d", "13n": return "snow"
        case "50d", "50n": return "cloud.fog.fill"
        default: return "questionmark.circle"
        }
    }
}

struct Weather: Decodable {
    let temp: Double
    let feelsLike: Double
    let humidity: Int
    let maxTemp: Double
    let minTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
        case maxTemp = "temp_max"
        case minTemp = "temp_min"
    }
}

extension Weather {
    static var preview: Weather {
        Weather(
            temp: 26.5,
            feelsLike: 27.8,
            humidity: 60,
            maxTemp: 30.0,
            minTemp: 22.0
        )
    }
}

struct Wind: Decodable {
    let speed: Double
    
    var windSpeed: String {
        let speedInKmh = speed * 3.6
        return String(format: "%.1f km/h", speedInKmh)
    }
}
