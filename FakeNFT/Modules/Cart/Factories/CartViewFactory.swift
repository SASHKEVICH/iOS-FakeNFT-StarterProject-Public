import Foundation

struct CartViewFactory {
    static func create() -> CartViewController {
        let networkClient = DefaultNetworkClient()

        let orderService = OrderService(networkClient: networkClient)
        let nftService = NFTNetworkServiceImpl(networkClient: networkClient)
        let imageLoadingService = ImageLoadingService()

        let cartViewInteractor = CartViewInteractor(
            nftService: nftService,
            orderService: orderService,
            imageLoadingService: imageLoadingService
        )
        let orderSorter = CartOrderSorter()

        let viewModel = CartViewModel(intercator: cartViewInteractor, orderSorter: orderSorter)
        let tableViewHelper = CartTableViewHelper()

        let currenciesService = CurrenciesService(networkClient: networkClient)
        let router = CartViewRouter(
            currenciesService: currenciesService,
            imageLoadingService: imageLoadingService,
            orderPaymentService: orderService
        )

        let viewController = CartViewController(
            viewModel: viewModel,
            tableViewHelper: tableViewHelper,
            router: router
        )
        return viewController
    }
}