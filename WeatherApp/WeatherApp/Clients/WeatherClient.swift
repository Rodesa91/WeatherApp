import Foundation

struct WeatherClient {
    
    func fetchWeather(location: Location) async throws -> WeatherResponse {
        guard let url = APIEndpoint.endpointURL(for: .weatherByLocation(location)) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func fetchHourlyForecast(location: Location) async throws -> [HourlyForecast] {
        guard let url = APIEndpoint.endpointURL(for: .hourlyForecastByLocation(location)) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            let forecastResponse = try JSONDecoder().decode(HourlyForecastResponse.self, from: data)
            return forecastResponse.list
        } catch {
            throw NetworkError.decodingError
        }
    }
}
