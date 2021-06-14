
import UIKit
import CoreLocation

protocol LocationDelegate: class {
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    weak var locationDelegate: LocationDelegate?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        guard let location = location.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        locationDelegate?.getWeather(latitude: latitude, longitude: longitude)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            guard let delegate = locationDelegate as? UIViewController else { return }
            Alert.locationServiceIsDesable(delegate)
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location", error)
    }
    
    
    
    
}

