import UIKit

extension UILabel {
    var lineHeight: CGFloat {
        get { 0 }
        set {
            let lineHeight = newValue
            let mutableParagraphStyle = NSMutableParagraphStyle()
            mutableParagraphStyle.minimumLineHeight = lineHeight
            mutableParagraphStyle.maximumLineHeight = lineHeight

            self.attributedText = NSAttributedString(
                string: self.text ?? "",
                attributes: [.paragraphStyle: mutableParagraphStyle]
            )
        }
    }
}
