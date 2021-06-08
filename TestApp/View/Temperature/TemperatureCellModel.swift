
import Foundation

struct TemperatureCellModel:  TableViewCellModel{
    let temperature: String
    func set(_ cell: TemperatureCell) {
        cell.temperature = temperature
    }
    
}
