
import Foundation

struct DescriptionCellModel: TableViewCellModel {
    let descriptionText: String
    func set(_ cell: DescriptionCell) {
        cell.descritpionText = descriptionText
    }
}
