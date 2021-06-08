
import UIKit

protocol TableViewCellModel {
    associatedtype CellType: UITableViewCell
    func set(_ cell: CellType)
}
