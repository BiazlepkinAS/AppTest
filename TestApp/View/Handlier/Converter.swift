
import Foundation

struct Converter {
    
    static func convert(_ viewModel: ViewModel) -> (city: String, Description: String, temperature: String, sunRiseTime: String, sunSetTime: String, humidity: String, precipitation: String, windSpeed: String, feelsLike: String, pressure: String, visibility: String, uvindex:String, cloudness: String) {
        
        
        let timezone = viewModel.weather.timezone
        let timeZoneSplited = timezone.split(separator: "/")
        var city = String(timeZoneSplited.last ?? "")
        city = city.contains("_") ? city.replacingOccurrences(of: "_", with: "_") : city
        
        let description = viewModel.weather.current?.weather.first?.main ?? ""
        
        let tempDouble = viewModel.weather.current?.temp ?? 0.0
        let temperature = convert(tempDouble) + "°"
        
        var sunRiseTime = ""
        if let sunRiseUnixTime = viewModel.weather.current?.sunrise {
            sunRiseTime = convert(unixTime: sunRiseUnixTime, with: "HH:mm")
        }
        var sunSetTime = ""
        if let sunSetUnixTime = viewModel.weather.current?.sunset {
            sunSetTime = convert(unixTime: sunSetUnixTime, with: "HH:mm")
        }
        let humidityInt = viewModel.weather.current?.humidity
        let humidity = humidityInt?.description ?? "--"
        var precipitation = "0 mm"
        if let precipitationDouble = viewModel.weather.current?.rain?.forLastHour {
            precipitation = convert(precipitationDouble) + "mm"
        }
        var windSpeed = "-- km/h"
        if let windSpeedDouble = viewModel.weather.current?.windSpeed {
            let windSpeedDoubleKM = windSpeedDouble * 3.6
            windSpeed = convert(windSpeedDoubleKM) + "km/h"
        }
        var feelsLike = "--°"
        if let feelsLikeDouble = viewModel.weather.current?.feelsLike {
            feelsLike = convert(feelsLikeDouble) + "°"
        }
        var pressure = "-- hPa"
        if let pressureInt = viewModel.weather.current?.pressure {
            pressure = String(pressureInt) + " hPa"
        }
        var visibility = "-- km"
        if let visibilityInt = viewModel.weather.current?.visibility {
            
           var visibilityDecimal = (visibilityInt % 1000)/100
            if (visibilityInt % 100) >= 50 {
                visibilityDecimal += 1
            }
            switch visibilityDecimal {
            case 0:
                visibility = String(visibilityInt / 1000) + " km"
            default:
                visibility = String(visibilityInt/1000) + "," + String(visibilityDecimal) + " km"
            }
        }
        var uvindex = "--"
        if let uvindexDouble = viewModel.weather.current?.uvi {
            uvindex = String(uvindexDouble)
        }
        var cloudness = "-- %"
        if let cloudnessInt = viewModel.weather.current?.clouds {
            cloudness = String(cloudnessInt) + "%"
        }
        return (city,description, temperature, sunRiseTime, sunSetTime, humidity, precipitation, windSpeed, feelsLike,pressure,visibility, uvindex,cloudness)
        
    }
    
    private static func convert(_ value: Double) -> String {
        let valueInt = Int(value.rounded())
        return String(valueInt)
    }
    
    private static func convert(_ dayli: Daily) -> (weekDay: String, icon: String, tempMax: String, tempMin: String) {
        let unixTime = dayli.dt
        let weekday = getWeekDay(from: unixTime)
        let icon = dayli.weather.first?.icon ?? ""
        let tempMaxDouble = dayli.temp.max
        let tempMax = convert(tempMaxDouble)
        let tempMinDouble = dayli.temp.min
        let tempMin = convert(tempMinDouble)
        return (weekday, icon, tempMax, tempMin)
    }
    
    private static func convert(_ hourly: Hourly) -> (hour: String, temperature: String, icon: String) {
        let unixTime = hourly.dt
        let hour = convert(unixTime: unixTime, with: "HH")
        let tempDouble = hourly.temp
        let temperature = convert(tempDouble) + "°"
        let icon = hourly.weather.first?.icon ?? ""
        return (hour, temperature, icon)
    }

    private static func convert(unixTime: Int, with dateFormat: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = .current
        return formatter.string(from: date)
    }
    private static func getWeekDay(from unixTime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let calendar = Calendar(identifier: .gregorian)
        switch calendar.component(.weekday, from: date) {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return ""
        }
    }
}
