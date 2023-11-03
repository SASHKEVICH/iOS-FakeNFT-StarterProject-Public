import UIKit

final class SortAlertBuilder {
    
    private init() {}
    
    static func buildSortAlert(
        onNameSort: @escaping () -> Void,
        onRatingSort: @escaping () -> Void) -> UIAlertController {
            let sortAlertController = UIAlertController(title: "Сортировка".localized,message: nil, preferredStyle: .actionSheet)

            sortAlertController.addAction(UIAlertAction(title: "По имени".localized,
                                                        style: .default) { _ in
                onNameSort()
            })
            sortAlertController.addAction(UIAlertAction(title: "По рейтингу".localized,
                                                        style: .default) { _ in
                onRatingSort()
            })
            sortAlertController.addAction(UIAlertAction(title: "Закрыть".localized,
                                                        style: .cancel))

            return sortAlertController
        }
}
