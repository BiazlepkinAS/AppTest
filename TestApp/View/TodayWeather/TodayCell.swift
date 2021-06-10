
import UIKit

class TodayCell: UITableViewCell {
    
    static let reusedId = "TodayCell"
    
    var weekDay: String?
    var tempMin: String?
    var tempMax: String?
    var icon: String?
    
    private let weekDayLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(named: "DarkMode")
        label.textAlignment = .left
        
        return label
    }()
    
    private let tempMinLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .lightText
        label.textAlignment = .left
    
        return label
    }()
    private let tempMaxLAbel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(named: "DarkMode")
        label.textAlignment = .left
        
        return label
    }()
    
    private let todayLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(named: "DarkMode")
        label.textAlignment = .left
        
        return label
    }()
    
    private let weatherImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        isUserInteractionEnabled = false
        separatorInset = UIEdgeInsets(top: 0.0, left: UIScreen.main.bounds.width, bottom: 0.0, right: 0.0)
        
        weekDayLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
        todayLabel.anchor(top: nil, left: weekDayLabel.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
        weatherImageView.anchor(top: topAnchor, left: todayLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        tempMinLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 40, height: 40)
        tempMaxLAbel.anchor(top: topAnchor, left: nil, bottom: nil, right: tempMinLabel.leftAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 404, height: 40)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        weekDayLabel.text = weekDay
        todayLabel.text = "TODAY"
        tempMinLabel.text = tempMin
        tempMaxLAbel.text = tempMax
        if let icon = icon {
            weatherImageView.image = UIImage(named: icon)
        }
    }
}
