
import Foundation
import CoreLocation

protocol ViewModelDelegate: class {
    
    func useData(_ data: Weather)
    func updateData(_ data: Weather)
}

class ViewModel {
    
    weak var viewModelDelegate: ViewModelDelegate?
    var weather: Weather
    private var dataHasResived = false
    
    init(weather: Weather) {
        self.weather = weather
    }
    func getWeatherFromCash() {
        DataHandler.getWeatherFromCash { [weak self] (weather) in
            guard let self = self else {return}
            self.viewModelDelegate?.useData(weather)
        }
    }
}

extension ViewModel: LocationDelegate {
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        switch dataHasResived {
        case false:
            DataHandler.getData(latitude: latitude, longitude: longitude) { [weak self] (weather, error ) in
                
                switch error {
                case nil:
                    self?.dataHasResived = true
                    guard let weather = weather else { return }
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
