import Foundation

extension NumberFormatter {
    static let doubleFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}
