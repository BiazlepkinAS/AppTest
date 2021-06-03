import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let item1 = TodayViewController()
        let item2 = ForecastViewController()
        let icon1 = UITabBarItem(title: "Today", image: UIImage(named: "today"), selectedImage: UIImage(named: "today"))
        let icon2 = UITabBarItem(title: "Forecast", image: UIImage(named: "forecast"), selectedImage: UIImage(named: "forecast"))
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        let controllers = [item1, item2]
        self.viewControllers = controllers
        self.selectedIndex = 0
        
    }
    
}
