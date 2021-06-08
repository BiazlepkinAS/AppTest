
import Foundation

struct DailyCellModel: TableViewCellModel {
    let weekDay: String
    let icon: String
    let tempMin: String
    let tempMax: String
    
    func set(_ cell: DayliCell) {
        cell.weekDay = weekDay
        cell.icon = icon
        cell.tempMin = tempMin
        cell.tempMax = tempMin
    }
}
