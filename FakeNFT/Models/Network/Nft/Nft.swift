import Foundation

struct Nft: Codable, Hashable {
    let createdAt: String
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
            fmt.currencyCode = "ETH"
            fmt.maximumFractionDigits = 0
            fmt.locale = Locale(identifier: "ru_RU")
            return fmt
        }()

        var formattedPrice: String {
            guard let result = Nft.formatter.string(from: NSNumber(value: price)) else {
                return "INVALID_PRICE_FORMAT".localized
            }

            return result
        }

    }
