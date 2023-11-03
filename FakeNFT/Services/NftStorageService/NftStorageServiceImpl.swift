
import Foundation

final class NFtStorageServiceImpl: NFtStorageService {
    private static let favouriteNftKey = "FavouriteNftKey"
    private static let selectedNftKey = "SelectedNftKey"
    private let service: StorageService

    var favouriteNfts: Box<[Nft]> = .init([])

    var selectedNfts: Box<[Nft]> = .init([])

    private func fetchNftData(for key: String) -> Box<[Nft]>? {
        if let data: Data = service.get(
            key: key
        ),
           let nfts = try? JSONDecoder().decode([Nft].self, from: data) {
            return .init(nfts)
        }

        return nil
    }

    private func fetchSelectedNfts() {
        selectedNfts =
        fetchNftData(for: NFtStorageServiceImpl.selectedNftKey) ?? .init([])
    }

    private func fetchFavouriteNfts() {
        favouriteNfts =
        fetchNftData(for: NFtStorageServiceImpl.favouriteNftKey) ?? .init([])
    }

    init(storageService: StorageService) {
        self.service = storageService

        fetchSelectedNfts()
        fetchFavouriteNfts()
    }

    func selectNft(_ nft: Nft) {
        NftStorageQueue.shared.queue.sync {
            selectedNfts.value.append(nft)
            if let data = try? JSONEncoder().encode(selectedNfts.value) {
                service.set(
                    key: NFtStorageServiceImpl.selectedNftKey,
                    value: data
                )
            }
        }
    }

    func unselectNft(_ nft: Nft) {
        NftStorageQueue.shared.queue.sync {
            if let index = selectedNfts.value.firstIndex(where: { $0.id == nft.id }) {
                selectedNfts.value.remove(at: index)

                if let data = try? JSONEncoder().encode(selectedNfts.value) {
                    service.set(
                        key: NFtStorageServiceImpl.selectedNftKey,
                        value: data
                    )
                }
            }
        }
    }

    func addToFavourite(_ nft: Nft) {
        NftStorageQueue.shared.queue.sync {
            favouriteNfts.value.append(nft)
            if let data = try? JSONEncoder().encode(favouriteNfts.value) {
                service.set(
                    key: NFtStorageServiceImpl.favouriteNftKey,
                    value: data
                )
            }
        }
    }

    func removeFromFavourite(_ nft: Nft) {
        if let index = favouriteNfts.value.firstIndex(where: { $0.id == nft.id }) {
            selectedNfts.value.remove(at: index)
            if let data = try? JSONEncoder().encode(favouriteNfts.value) {
                service.set(
                    key: NFtStorageServiceImpl.favouriteNftKey,
                    value: data
                )
            }
        }
    }
}
