//
//  UIFont+Extensions.swift
//  FakeNFT
//
//  Created by Дмитрий Никишов on 28.07.2023.
//

import UIKit

extension UIFont {
    enum AppFonts: String {
        case regular = "SFPro-Regular"
        case medium = "SFPro-Medium"
        case bold = "SFPro-Bold"
    }

    static func getFont(style: AppFonts, size: CGFloat) -> UIFont {
        guard let font = UIFont(
            name: style.rawValue,
            size: size
        ) else {
            return UIFont.systemFont(ofSize: 8)
        }
        return font
    }
}
