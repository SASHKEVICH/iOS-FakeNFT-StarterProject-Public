//
//  CartView.swift
//  FakeNFT
//
//  Created by Aleksandr Bekrenev on 04.08.2023.
//

import UIKit

final class CartView: UIView {
    var onTapPurchaseButton: (() -> Void)?
    var tableViewHelper: CartTableViewHelperProtocol?

    private lazy var cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .appWhite
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self.tableViewHelper
        tableView.dataSource = self.tableViewHelper
        tableView.register<CartTableViewCell>(CartTableViewCell.self)
        return tableView
    }()

    private let purchaseBackgroundView: PurchaseBackgroundView = {
        let view = PurchaseBackgroundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let nftCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .getFont(style: .regular, size: 15)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let finalCostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .greenUniversal
        label.font = .getFont(style: .bold, size: 17)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var purchaseButton: AppButton = {
        let button = AppButton(type: .filled, title: "CART_PURCHASE_BUTTON_TITLE".localized)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.didTapPurchaseButton), for: .touchUpInside)
        return button
    }()

    private let placeholderView: CartPlaceholderView = {
        let view = CartPlaceholderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CartView {
    func reloadTableView() {
        self.cartTableView.reloadData()
    }

    func setNftCount(_ nftCount: String) {
        self.nftCountLabel.text = nftCount
    }

    func setFinalOrderCost(_ cost: String) {
        self.finalCostLabel.text = cost
    }

    func shouldHidePlaceholder(_ shouldHide: Bool) {
        self.placeholderView.isHidden = shouldHide
    }
}

private extension CartView {
    func configure() {
        self.addSubviews()
        self.addConstraints()
    }

    func addSubviews() {
        self.addSubview(self.cartTableView)
        self.addSubview(self.purchaseBackgroundView)
        self.addSubview(self.placeholderView)

        self.purchaseBackgroundView.addSubview(self.purchaseButton)
        self.purchaseBackgroundView.addSubview(self.nftCountLabel)
        self.purchaseBackgroundView.addSubview(self.finalCostLabel)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            self.cartTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.cartTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.cartTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.cartTableView.bottomAnchor.constraint(equalTo: self.purchaseBackgroundView.topAnchor),

            self.purchaseBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.purchaseBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.purchaseBackgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.purchaseBackgroundView.heightAnchor.constraint(equalToConstant: 76),

            self.nftCountLabel.topAnchor.constraint(equalTo: self.purchaseBackgroundView.topAnchor, constant: 16),
            self.nftCountLabel.leadingAnchor.constraint(equalTo: self.purchaseBackgroundView.leadingAnchor, constant: 16),
            self.nftCountLabel.trailingAnchor.constraint(equalTo: self.purchaseButton.leadingAnchor, constant: -24),

            self.finalCostLabel.topAnchor.constraint(equalTo: self.nftCountLabel.bottomAnchor, constant: 2),
            self.finalCostLabel.leadingAnchor.constraint(equalTo: self.purchaseBackgroundView.leadingAnchor, constant: 16),
            self.finalCostLabel.trailingAnchor.constraint(equalTo: self.purchaseButton.leadingAnchor, constant: -24),

            self.purchaseButton.topAnchor.constraint(equalTo: self.purchaseBackgroundView.topAnchor, constant: 16),
            self.purchaseButton.trailingAnchor.constraint(equalTo: self.purchaseBackgroundView.trailingAnchor, constant: -16),
            self.purchaseButton.bottomAnchor.constraint(equalTo: self.purchaseBackgroundView.bottomAnchor, constant: -16),

            self.placeholderView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.placeholderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.placeholderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.placeholderView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Actions
private extension CartView {
    @objc
    func didTapPurchaseButton() {
        self.onTapPurchaseButton?()
    }
}