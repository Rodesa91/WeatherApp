import Foundation

enum APIEndpoint {
    
    static let baseURL = "https://api.openweathermap.org"
    
    case coordinatesByLocationName(String)
    case weatherByLocation(Location)
    case hourlyForecastByLocation(Location)
    
    private var path: String {
        switch self {
        case .coordinatesByLocationName(let city):
            return "/geo/1.0/direct?q=\(city)&limit=15&appid=\(Constants.keys.weatherApiKey)"
        case .weatherByLocation(let location):
            return "/data/2.5/weather?lat=\(location.latitude)&lon=\(location.longitude)&units=metric&appid=\(Constants.keys.weatherApiKey)"
        case .hourlyForecastByLocation(let location):
            return "/data/2.5/forecast?lat=\(location.latitude)&lon=\(location.longitude)&units=metric&appid=\(Constants.keys.weatherApiKey)"
        }
    }
    
    static func endpointURL(for endpoint: APIEndpoint) -> URL? {
        let endpointPath = endpoint.path
        let stringURL = baseURL + endpointPath
        return URL(string: stringURL)
    }
}
