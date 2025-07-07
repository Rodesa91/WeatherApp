import Foundation

struct Location: Decodable {
    let name: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lon"
    }
}
