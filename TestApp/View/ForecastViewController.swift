
import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    
    private let backgroundView: UIImageView = {
        let image = UIImage(named: "ImageDark")
        let bgView = UIImageView(image: image)
        bgView.isUserInteractionEnabled = true
        return bgView
    }()

    var viewModel: ViewModel! {
        didSet {
            let data = Converter.convert(viewModel)
        }
    }
    private var locationManagerDelegate: LocationManagerDelegate?
    private var locationManager = CLLocationManager()
    private var tableViewDelegate: UITableViewDelegate?
    private var tableViewDataSource: UITableViewDataSource?
    
    override func loadView() {
        super.loadView()
        view = backgroundView
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
    }
}

extension ForecastViewController: ViewModelDelegate {
    func useData(_ data: Weather) {
        viewModel = ViewModel(weather: data)
        configure()
    }
    func updateData(_ data: Weather) {
        viewModel = ViewModel(weather: data)
        configure()
    }
}
