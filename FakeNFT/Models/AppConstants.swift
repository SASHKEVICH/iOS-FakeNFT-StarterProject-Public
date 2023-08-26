//
//  AppConstants.swift
//  FakeNFT
//
//  Created by Дмитрий Никишов on 28.07.2023.
//

import Foundation

struct AppConstants {
    struct Icons {
        static let cart = "CartIcon"
        static let catalog = "CatalogueIcon"
        static let profile = "ProfileIcon"
        static let statistics = "StatisticsIcon"

        static let sort = "SortIcon"
    }

    enum Api {
        static let version = "/api/v1"
        static let defaultEndpoint = "https://64c51750c853c26efada7c53.mockapi.io"

        enum Cart {
            static let controller = "orders"
            static let paymentController = "payment"
        }

        enum Currencies {
            static let controller = "currencies"
        }

        enum Nft {
            static let controller = "nft"
        }
    }

    enum Links {
        static let purchaseUserAgreement = "https://yandex.ru/legal/practicum_termsofuse/"
    }
    struct String {
        static let sortOrder = "sortOrder"
    }
}
