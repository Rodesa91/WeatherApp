import Foundation

struct Location: Decodable, Identifiable, Hashable {
    var id: String { "\(name)-\(latitude)-\(longitude)" }
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lon"
        case country
    }
    
    var displayName: String {
        "\(name), \(country)"
    }
}

extension Location {
    static var preview: Location {
        .init(name: "Montevideo", latitude: -34.91, longitude: -56.19, country: "UY")
    }
}
