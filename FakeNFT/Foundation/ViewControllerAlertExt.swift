import UIKit

extension UIViewController {
    
    func presentErrorDialog(message: String?) {
        let errorDialog = UIAlertController(title: "Ошибка!".localized, message: message, preferredStyle: .alert)
        errorDialog.addAction(UIAlertAction(title: "Ок".localized, style: .default))
        present(errorDialog, animated: true)
    }
    
}
