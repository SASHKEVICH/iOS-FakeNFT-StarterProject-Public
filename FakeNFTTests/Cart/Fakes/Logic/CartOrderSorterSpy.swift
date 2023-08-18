import Foundation
import FakeNFT

final class CartOrderSorterSpy: CartOrderSorterProtocol {
    var didSortingCalled = false
    var selectedSortingTrait: CartOrderSorter.SortingTrait = .name

    let sortedOrder: OrderViewModel = []

    func sort(
        order: FakeNFT.OrderViewModel,
        trait: FakeNFT.CartOrderSorter.SortingTrait,
        completion: @escaping FakeNFT.LoadingCompletionBlock<FakeNFT.OrderViewModel>
    ) {
        self.didSortingCalled = true
        self.selectedSortingTrait = trait

        completion(self.sortedOrder)
    }
}