import Foundation
import CoreLocation

protocol ViewModelDelegate: AnyObject {
    
    func useData(_ data: Weather)
    func updateData(_ data: Weather)
}

class ViewModel {
    
    weak var viewModelDelegate: ViewModelDelegate?
    var weather: Weather
    private var dataHasReceived = false
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    func getWeatherFromCache() {
        DataHandler.getWeatherFromCashe { [weak self] (weather) in
            guard let self = self else {return}
            self.viewModelDelegate?.useData(weather)
        }
    }
}

extension ViewModel: LocationDelegate {
    
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        switch dataHasReceived {
        case false:
            DataHandler.getData(latitude: latitude, longitude: longitude) { [weak self] (weather, error) in
                
                switch error {
                case nil:
                    self?.dataHasReceived = true
                    guard let weather = weather else {return}
                    self?.viewModelDelegate?.updateData(weather)
                    
                default:
                    print(String(describing: error?.localizedDescription))
                }
            }
        default:
            break
        }
    }
}
