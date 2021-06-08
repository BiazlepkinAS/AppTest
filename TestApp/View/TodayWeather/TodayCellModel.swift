
import Foundation

struct TodayCellModel: TableViewCellModel {
    
    let weekDay: String
    let tempMin: String
    let tempMax: String
    
    func set(_ cell: TodayCell) {
        cell.weekDay = weekDay
        cell.tempMin = tempMin
        cell.tempMax = tempMax
    }
}
