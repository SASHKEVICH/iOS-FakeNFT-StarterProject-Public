import Foundation

enum SortUserDefaults: Int {
    case sortByName
    case sortByRating
    
    func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(rawValue, forKey: "sortOption")
    }
    
    static func loadFromUserDefaults() -> SortUserDefaults {
        let defaults = UserDefaults.standard
        
        if let rawValue = defaults.value(forKey: "sortOption") as? Int,
           let sortOption = SortUserDefaults(rawValue: rawValue) {
            return sortOption
        }
        return .sortByName
    }
}
