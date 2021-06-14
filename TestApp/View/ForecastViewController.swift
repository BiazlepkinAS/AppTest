
import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    
    private let backgroundView: UIImageView = {
        let image = UIImage(named: "Splash")
        let bgView = UIImageView(image: image)
        bgView.isUserInteractionEnabled = true
        return bgView
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = ""
        return label
    }()
    
    private let tableView:UITableView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let tableView = UITableView(frame: frame, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .lightText
        return tableView
    }()
    var viewModel: ViewModel! {
        didSet {
            let data = Converter.convert(viewModel)
            descriptionLabel.text = data.description
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
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableViewDataSource = TableViewDataSource()
        tableView.dataSource = tableViewDataSource
        if let tableViewDatatSource = tableViewDataSource as? TableViewDataSource {
            tableViewDatatSource.viewModel = self.viewModel
            tableViewDatatSource.tableView = self.tableView
        }
        tableViewDelegate = TableViewDelegate()
        tableView.delegate = tableViewDelegate
        if let tableViewDelegate = tableViewDelegate as? TableViewDelegate {
            tableViewDelegate.viewModel = self.viewModel
        }
        
        tableView.register(TemperatureCell.self, forCellReuseIdentifier: TemperatureCell.reusedID)
        tableView.register(TodayCell.self, forCellReuseIdentifier: TodayCell.reusedId)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.reusedID)
//        tableView.register(DailyCell.self, forCellReuseIdentifier: DayliCell.reusedId)
        tableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: CurrentWeatherCell.reusedId)
        
    }
    
    

}

extension ForecastViewController: ViewModelDelegate {
    func useData(_ data: Weather) {
        viewModel = ViewModel(weather: data)
        configure()
//        configureTableView()
        tableView.reloadData()
    }
    
    func updateData(_ data: Weather) {
        viewModel = ViewModel(weather: data)
        configure()
//        configureTableView()
        tableView.reloadData()
    }
}
