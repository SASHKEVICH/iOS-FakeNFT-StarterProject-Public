import Foundation

struct Nft: Codable, Hashable {
    let createdAt: Date
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Double
    let author: String
    let id: String

    private static let formatter: NumberFormatter = {
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        fmt.currencyCode = "ETH".localized
        fmt.maximumFractionDigits = 0
        fmt.locale = Locale(identifier: "ru_RU".localized)
        return fmt
    }()

    var formattedPrice: String {
        guard let result = Nft.formatter.string(from: NSNumber(value: price)) else {
            return "INVALID_PRICE_FORMAT".localized
        }

        return result
    }

}
