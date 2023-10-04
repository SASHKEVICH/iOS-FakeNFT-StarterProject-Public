import Foundation
protocol NFtStorageService {
    var favouriteNfts: Box<[Nft]> { get }
    var selectedNfts: Box<[Nft]> { get }

    func selectNft(_ nft: Nft)
    func unselectNft(_ nft: Nft)

    func addToFavourite(_ nft: Nft)
    func removeFromFavourite(_ nft: Nft)
}
