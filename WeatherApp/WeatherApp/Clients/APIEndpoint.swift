import Foundation

enum APIEndpoint {
    
    static let baseURL = "https://api.openweathermap.org"
    
    case coordinatesByLocationName(String)
    case weatherByCoordinates(Double, Double)
    
    private var path: String {
        switch self {
        case .coordinatesByLocationName(let city):
            return "/geo/1.0/direct?q\(city)&appid=\(Constants.keys.weatherApiKey)"
        case .weatherByCoordinates(let latitude, let longitude):
            return "/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(Constants.keys.weatherApiKey)"
        }
    }
    
    static func endpointURL(for endpoint: APIEndpoint) -> URL {
        let endpointPath = endpoint.path
        let stringURL = baseURL + endpointPath
        return URL(string: stringURL)!
    }
}
