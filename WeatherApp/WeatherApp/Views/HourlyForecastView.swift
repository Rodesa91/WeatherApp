import SwiftUI

struct HourlyForecastView: View {
    let hourlyForecasts: [HourlyForecast]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Today")
                .font(.headline)
                .padding(.bottom, 8)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(hourlyForecasts.prefix(8)) { forecast in
                        VStack {
                            Text(hourString(from: forecast.dt))
                                .font(.caption)
                                .foregroundColor(.primary)
                            Image(systemName: iconName(for: forecast.weather.first?.icon ?? "01d"))
                                .foregroundColor(.blue)
                                .padding(.all, 4)
                            Text("\(Int(forecast.main.temp.rounded()))°")
                                .bold()
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                }
            }
        }
    }

    func hourString(from timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    func iconName(for icon: String) -> String {
        switch icon {
        case "01d": return "sun.max.fill"
        case "01n": return "moon.stars.fill"
        case "02d": return "cloud.sun.fill"
        case "02n": return "cloud.moon.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "smoke.fill"
        case "09d", "09n": return "cloud.drizzle.fill"
        case "10d": return "cloud.sun.rain.fill"
        case "10n": return "cloud.moon.rain.fill"
        case "11d", "11n": return "cloud.bolt.rain.fill"
        case "13d", "13n": return "snowflake"
        case "50d", "50n": return "cloud.fog.fill"
        default: return "cloud"
        }
    }
}

#Preview {
    let data = HourlyForecast.mockData
    VStack {
        Spacer()
        HourlyForecastView(hourlyForecasts: data)
            .padding()
        Spacer()
    }
}

