import Foundation

struct HourlyForecastResponse: Decodable {
    let list: [HourlyForecast]
}

struct HourlyForecast: Decodable, Identifiable {
    let id = UUID()
    let dt: TimeInterval
    let main: HourlyMain
    let weather: [HourlyWeather]
    let dt_txt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, dt_txt
    }
}

struct HourlyMain: Decodable {
    let temp: Double
}

struct HourlyWeather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
} 

extension HourlyWeather {
    static var preview: HourlyWeather {
        HourlyWeather(
            id: 800,
            main: "Clear",
            description: "clear sky",
            icon: "01d"
        )
    }
}

extension HourlyForecast {
    public static var mockData: [HourlyForecast] {
        let baseTimestamp = Date().timeIntervalSince1970
        return (0..<8).map { i in
            HourlyForecast(
                dt: baseTimestamp + Double(i * 3600),
                main: .init(temp: Double.random(in: 20.0...24.0)),
                weather: [HourlyWeather.preview],
                dt_txt: ""
            )
        }
    }
}
