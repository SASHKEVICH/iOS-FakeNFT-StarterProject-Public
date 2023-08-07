//
//  ProgressHUDWrapper.swift
//  FakeNFT
//
//  Created by Aleksandr Bekrenev on 03.08.2023.
//

import UIKit
import ProgressHUD

struct ProgressHUDWrapper {
    private static var window: UIWindow? {
        UIApplication.shared.windows.first
    }

    static func show() {
        self.window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }

    static func hide() {
        self.window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
