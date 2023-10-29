import Foundation

final class RatingViewModel {
    
    @Observable
    private(set) var userList: [User] = []
    
    @Observable
    private(set) var isLoading: Bool = false
    
    @Observable
    private(set) var errorMessage: String? = nil
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserNetworkService()) {
        self.userService = userService
    }
    
    func getUserList() {
        isLoading = true
        
        userService.getUserList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                let selectedSortOption = SortUserDefaults.loadFromUserDefaults()
                switch result {
                case .success(let userList):
                    let sortedList = self?.sortByRating(userList: userList) ?? []
                    self?.userList = sortedList
                    self?.applySortOption(selectedSortOption: selectedSortOption)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func sortByName() {
        let sortedList = userList.sorted { user1, user2 in
            user1.name < user2.name
        }
        saveSortOption(.sortByName)
        self.userList = sortedList
    }
    
    func sortByRating() {
        let sortedList = sortByRating(userList: userList)
        saveSortOption(.sortByRating)
        self.userList = sortedList
    }
    
    private func sortByRating(userList: [User]) -> [User] {
        userList.sorted { user1, user2 in
            (Int(user1.rating) ?? 0) > (Int(user2.rating) ?? 0)
        }
    }
    private func saveSortOption(_
                                sortOption: SortUserDefaults) {
        sortOption.saveToUserDefaults()
    }
    
    func sortByname() {
        let sortedList = userList.sorted { user1, user2 in
            user1.name < user2.name
        }
        saveSortOption(.sortByName)
        self.userList = sortedList
    }
    
    func sortByRaiting() {
        let sortedList = sortByRating(userList: userList)
        saveSortOption(.sortByRating)
        self.userList = sortedList
    }

    func applySortOption(selectedSortOption: SortUserDefaults) {
                    switch selectedSortOption {
                    case .sortByRating: sortByRating()
                    case .sortByName: sortByName()
                    }
                }
            }
