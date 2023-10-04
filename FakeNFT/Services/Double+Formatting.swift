import Foundation

extension Double {
    var nftCurrencyFormatted: String {
        let formatter = NumberFormatter.doubleFormatter
        let string = formatter.string(from: self as NSNumber)
        return string ?? ""
    }
}
