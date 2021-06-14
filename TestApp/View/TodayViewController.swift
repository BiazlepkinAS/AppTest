
import UIKit
import  CoreLocation

class TodayViewController: UIViewController {
    
    private let backGroundView: UIView = {
       let image = UIImage(named: "DarkMode")
        let bgvImage = UIImageView(image: image)
        bgvImage.isUserInteractionEnabled = true
        return bgvImage
    }()
    private let locationLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(named: "DarckMode")
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    var viewModel: ViewModel! {
        didSet {
            let data = Converter.convert(viewModel)
            locationLabel.text = data.city
        }
    }
    private var locationManagerDelegate: LocationManagerDelegate?
    private var locationManager = CLLocationManager()
    
    override func loadView() {
        super.loadView()
        view = backGroundView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherData = Weather(lat: 0.0, lon: 0.0, timezone: " ", current: nil, hourly: nil, daily: nil)
        viewModel = ViewModel(weather: weatherData)
        viewModel.viewModelDelegate = self
        
        viewModel.getWeatherFromCache()
        configureLocationManager()
        APIHandler.viewController = self
        
    }
    private func configureLocationManager() {
        locationManagerDelegate = LocationManagerDelegate()
        locationManager.delegate = locationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManagerDelegate?.locationDelegate = self.viewModel
        
    }
    private func configure() {
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
       
    }
    
    
    
}
extension TodayViewController: ViewModelDelegate {
    func useData(_ data: Weather) {
        viewModel = ViewModel(weather: data)
        configure()
    }
    
    func updateData(_ data: Weather) {
        viewModel = ViewModel(weather: data)
        configure()
    }
}
