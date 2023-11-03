
import Foundation

protocol StorageService {
    func get<T>(key: String) -> T?
    func set<T>(key: String, value: T?)
    func deleteObject(key: String)
}
