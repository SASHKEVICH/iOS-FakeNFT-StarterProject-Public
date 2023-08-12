//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Aleksandr Bekrenev on 31.07.2023.
//

import Foundation

protocol CartViewModelProtocol {
    var order: Box<OrderViewModel> { get }
    var nftCount: Box<String> { get }
    var finalOrderCost: Box<String> { get }
    var cartViewState: Box<CartViewModel.ViewState> { get }
    var error: Box<Error?> { get }

    var tableViewChangeset: Changeset<NFTCartCellViewModel>? { get }
    var orderId: String { get }

    func fetchOrder()
    func sortOrder(trait: CartOrderSorter.SortingTrait)
    func removeNft(row: Int)
}

final class CartViewModel {
    enum ViewState {
        case loading
        case loaded(OrderViewModel, Double)
        case empty
    }

    private(set) var order = Box<OrderViewModel>([])
    private(set) var nftCount = Box<String>("0 NFT")
    private(set) var finalOrderCost = Box<String>("0 ETH")
    private(set) var cartViewState = Box<ViewState>(.loading)
    private(set) var error = Box<Error?>(nil)

    private(set) var tableViewChangeset: Changeset<NFTCartCellViewModel>?

    private(set) var orderId = "1"

    private lazy var successCompletion: LoadingCompletionBlock = { [weak self] (viewState: ViewState) in
        guard let self = self else { return }

        self.cartViewState.value = viewState

        switch viewState {
        case .loaded(let order, let cost):
            self.setOrderAnimated(newOrder: order)
            self.nftCount.value = "\(order.count) NFT"
            self.finalOrderCost.value = "\(cost.nftCurrencyFormatted) ETH"
        default:
            break
        }
    }

    private lazy var failureCompletion: LoadingFailureCompletionBlock = { [weak self] error in
        self?.error.value = error
        self?.cartViewState.value = .empty
    }

    private let cartViewInteractor: CartViewInteractorProtocol
    private let cartOrderSorter: CartOrderSorterProtocol

    init(
        intercator: CartViewInteractorProtocol,
        orderSorter: CartOrderSorterProtocol
    ) {
        self.cartViewInteractor = intercator
        self.cartOrderSorter = orderSorter
    }
}

// MARK: - CartViewModelProtocol
extension CartViewModel: CartViewModelProtocol {
    func fetchOrder() {
        switch self.cartViewState.value {
        case .loading:
            break
        default:
            self.cartViewState.value = .loading
        }

        self.cartViewInteractor.fetchOrder(
            with: self.orderId,
            onSuccess: self.successCompletion,
            onFailure: failureCompletion
        )
    }

    func sortOrder(trait: CartOrderSorter.SortingTrait) {
        self.cartOrderSorter.sort(order: self.order.value, trait: trait) { [weak self] sortedOrder in
            self?.setOrderAnimated(newOrder: sortedOrder)
        }
    }

    func removeNft(row: Int) {
        var newOrder = self.order.value
        newOrder.remove(at: row)
        let nftIds = newOrder.map { $0.id }

        self.cartViewState.value = .loading
        self.cartViewInteractor.changeOrder(
            with: self.orderId,
            nftIds: nftIds,
            onSuccess: self.successCompletion,
            onFailure: self.failureCompletion
        )
    }
}

private extension CartViewModel {
    func setOrderAnimated(newOrder: OrderViewModel) {
        self.tableViewChangeset = Changeset(oldItems: self.order.value, newItems: newOrder)
        self.order.value = newOrder
    }
}
