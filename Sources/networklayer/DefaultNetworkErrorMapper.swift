import Foundation

protocol NetworkErrorMapper {
    func map(error: Error) -> NetworkError
}

final class DefaultNetworkErrorMapper: NetworkErrorMapper {
    func map(error: Error) -> NetworkError {
        return .custom(error)
    }
}
