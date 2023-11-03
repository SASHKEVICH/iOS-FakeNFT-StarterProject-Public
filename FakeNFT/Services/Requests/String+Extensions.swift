import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    var encodeUrl: String {
        addingPercentEncoding(
            withAllowedCharacters: NSCharacterSet.urlQueryAllowed
        )!
    }

    var decodeUrl: String {
        removingPercentEncoding!
    }
}
