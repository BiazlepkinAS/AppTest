
import UIKit
import CoreLocation

struct APIHandler {
    static weak var viewController: UIViewController?
    static private var alertHasShow = false
    
    static func request(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping(Data?, Error?)-> Void) {
        
        let optURL = URLBuilder()
            .set(scheme: Constants.scheme)
            .set(host: Constants.host)
            .set(path: Constants.path + "onecall")
            .addQueryItem(name: "lat", value: "\(latitude)")
            .addQueryItem(name: "lon", value: "\(longitude)")
            .addQueryItem(name: "units", value: "\(Constants.metricFormat)")
            .addQueryItem(name: "appid", value: "\(Constants.apiKey)")
            .build()
        
        guard let url = optURL else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            switch error {
            case nil:
                completion(data, error)
            default:
                if alertHasShow == false {
                    guard let viewController = viewController else {return}
                    DispatchQueue.main.async {
                        // TODO: write Alert
                        Alert.noInternetConnection(viewController)
                        alertHasShow = true
                    }
                }
            }
        }.resume()
    }
}
