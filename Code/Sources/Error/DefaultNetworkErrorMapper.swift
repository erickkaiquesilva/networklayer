import Foundation

final class DefaultNetworkErrorMapper: NetworkErrorMapper {
    func map(error: Error) -> NetworkLayerError {
        return .custom(error)
    }
}
