import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidResponse
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from server"
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let code):
            return "Server error: \(code)"
        }
    }
}

struct GeocodingClient {
    
    func searchLocations(_ city: String) async throws -> [Location] {
        guard let url = APIEndpoint.endpointURL(for: .coordinatesByLocationName(city)) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        do {
            let locations = try JSONDecoder().decode([Location].self, from: data)
            return locations
        } catch {
            throw NetworkError.decodingError
        }
    }
}
