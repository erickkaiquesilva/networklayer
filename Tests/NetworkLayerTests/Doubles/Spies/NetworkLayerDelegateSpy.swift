@testable import NetworkLayer

final class NetworkLayerDelegateSpy: NetworkLayerDelegate {

    private(set) var authenticateCount: Int = 0
    func authenticate(completion: @escaping () -> Void?) {
        authenticateCount += 1
        completion()
    }
}
