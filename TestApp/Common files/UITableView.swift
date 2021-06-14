
import UIKit

extension UITableView {
    
    func dequeueReusebleCell<T: TableViewCellModel>(with model: T, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: T.CellType.self)
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = cell as? T.CellType {
            model.set(cell)
        }
        return cell
    }
}
