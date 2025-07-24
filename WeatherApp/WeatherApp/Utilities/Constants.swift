import Foundation

struct Constants {
    
    /*
        Generate your own API Key in https://openweathermap.org
     */
    struct keys {
        static let weatherApiKey: String = {
            if let apiKey = ProcessInfo.processInfo.environment["WEATHER_API_KEY"] {
                return apiKey
            }
            // Replace with your actual key
            return ""
        }()
    }
}
