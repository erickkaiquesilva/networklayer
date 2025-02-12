protocol NetworkErrorMapper {
    func map(error: Error) -> NetworkLayerError
}
