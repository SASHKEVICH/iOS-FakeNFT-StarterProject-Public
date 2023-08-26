import Foundation

public protocol OrderServiceProtocol {
    func fetchOrder(id: String, completion: @escaping ResultHandler<Order>)
    func changeOrder(id: String, nftIds: [String], completion: @escaping ResultHandler<Order>)
}

public protocol OrderPaymentServiceProtocol {
    func purchase(orderId: String, currencyId: String, completion: @escaping ResultHandler<PurchaseResult>)
}

final class OrderService {
    private let networkRequestSender: NetworkRequestSenderProtocol

    private var fetchingTask: DefaultNetworkTask?
    private var changingTask: DefaultNetworkTask?
    private var purchasingTask: DefaultNetworkTask?

    init(networkRequestSender: NetworkRequestSenderProtocol) {
        self.networkRequestSender = networkRequestSender
    }
}

// MARK: - CartServiceProtocol
extension OrderService: OrderServiceProtocol {
    func fetchOrder(id: String, completion: @escaping ResultHandler<Order>) {
        assert(Thread.isMainThread)
        guard !self.fetchingTask.isRunning else { return }

        let request = OrderRequest(orderId: id)
        let task = self.networkRequestSender.send(
            request: request,
            task: self.fetchingTask,
            type: Order.self,
            completion: completion
        )

        self.fetchingTask = task
    }

    func changeOrder(id: String, nftIds: [String], completion: @escaping ResultHandler<Order>) {
        assert(Thread.isMainThread)
        guard !self.changingTask.isRunning else { return }

        var request = OrderRequest(orderId: id)
        request.httpMethod = .put
        request.nftIds = nftIds

        let task = self.networkRequestSender.send(
            request: request,
            task: self.changingTask,
            type: Order.self,
            completion: completion
        )

        self.changingTask = task
    }
}

// MARK: - OrderPaymentServiceProtocol
extension OrderService: OrderPaymentServiceProtocol {
    func purchase(orderId: String, currencyId: String, completion: @escaping ResultHandler<PurchaseResult>) {
        assert(Thread.isMainThread)
        guard !self.purchasingTask.isRunning else { return }

        let request = PurchaseRequest(orderId: orderId, currencyId: currencyId)
        let task = self.networkRequestSender.send(
            request: request,
            task: self.purchasingTask,
            type: PurchaseResult.self,
            completion: completion
        )

        self.purchasingTask = task
    }
}
