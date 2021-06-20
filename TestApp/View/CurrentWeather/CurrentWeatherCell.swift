
import UIKit

class CurrentWeatherCell: UITableViewCell {
    
    static let reusedId = "CurrentWeatherCell"
    
    var leftTopLabelName: String! {
        didSet {
            leftTopLabel.text = leftTopLabelName
        }
    }
    var leftBottomLabelName: String! {
        didSet {
            leftBottomLabel.text = leftBottomLabelName
        }
    }
    var rightTopLabelName: String! {
        didSet {
            rightTopLAbel.text = rightTopLabelName
        }
    }
    var rightBottomLabelName: String! {
        didSet {
            rightBottomLabel.text = rightBottomLabelName
        }
    }
    
    private let leftTopLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondarySystemBackground
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        
        return label
    }()
    
    private let leftBottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = .secondarySystemBackground
        label.textAlignment = .left
        
        return label
    }()
    
    private let rightTopLAbel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textColor = .secondarySystemBackground
        label.textAlignment = .left
        
        return label
    }()
    
    private let rightBottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = .secondarySystemBackground
        label.textAlignment = .left
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        isUserInteractionEnabled = false
        separatorInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        
        addSubview(leftTopLabel)
        addSubview(leftBottomLabel)
        addSubview(rightTopLAbel)
        addSubview(rightBottomLabel)
        
        leftTopLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0)
        leftBottomLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 5, paddingRight: 0, width: frame.size.width / 2, height: 0)
        rightTopLAbel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: -120, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        rightBottomLabel.anchor(top: nil, left: rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: -120, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
