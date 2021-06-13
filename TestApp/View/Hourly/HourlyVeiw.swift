
import UIKit

class HouryVeiw: UIView {

    private let collectionView: UICollectionView
    private let viewModel:ViewModel
    
    private let headerViewHeight = CGFloat(120)
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width+2, height: headerViewHeight)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        layout.itemSize = CGSize(width: 40, height: 100)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: headerViewHeight))
        addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(HourlyViewCell.self, forCellWithReuseIdentifier: HourlyViewCell.reusedId)
        isUserInteractionEnabled = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HouryVeiw: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.weather.hourly?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyViewCell.reusedId, for: indexPath) as? HourlyViewCell else {return UICollectionViewCell()}
        switch indexPath.item {
        case 0:
            cell.hour = "Now"
            cell.hourLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
            cell.temperatureLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
            if let data = viewModel.weather.current?.weather.first {
                cell.icon = data.icon
            }
            let temperature = Converter.convert(viewModel).temperature
            cell.temperature = temperature
        
        default:
            if let hourlyArray = viewModel.weather.hourly {
                let hourly = hourlyArray[indexPath.item]
                let data = Converter.convert(hourlyArray)
                
            }
        }
        return cell

    }
}
