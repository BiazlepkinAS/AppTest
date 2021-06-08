
import UIKit

class TemperatureCell: UITableViewCell {
    
    static let reusedID = "TemperatureCell"
    var temperature: String?
    
    private let temperatureLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60, weight: .thin)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    
    
    
}
