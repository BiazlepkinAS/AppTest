
import UIKit

struct Alert {
    
    static func locationServiceIsDesable(_ sender: UIViewController) {
        
        let title = "Location Service are DISABLE"
        let message = "Please enable Location Service in your Settings"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        sender.present(alert, animated: true, completion: nil)
    }
    
    static func noInternetConnection(_ sender: UIViewController) {
        let title = "No Internet Connection"
        let message = "Please connect to Internet"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        sender.present(alert, animated: true, completion: nil)
    }
}
