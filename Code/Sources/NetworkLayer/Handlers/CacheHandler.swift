//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 22/02/25.
//

import Foundation

protocol CacheHandlerType: NetworkHandler {
    
    func getCachedResponse<T: Decodable>(
        for service: NetworkLayerServiceType,
        response: T.Type
    ) -> (T?, Error?)

    func saveCachedResponse<T: Encodable>(
        _ response: T,
        service: any NetworkLayerServiceType
    ) -> Error?
}

struct CacheHandler: CacheHandlerType {

    weak var delegate: (any NetworkLayerDelegate)?

    // MARK: - Private properties
    private let cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()
    private let ttl: TimeInterval

    // MARK: - Initializer
    init(ttl: TimeInterval) {
        self.ttl = ttl
    }

    // MARK: - Private methods
    private func shouldCache(_ isCache: Bool) -> Bool {
        return isCache
    }

    // MARK: - Interface methods
    func getCachedResponse<T: Decodable>(
        for service: any NetworkLayerServiceType,
        response: T.Type
    ) -> (T?, Error?) {
        guard shouldCache(service.cache),
              let cachedData = cache.object(forKey: service.path as NSString) as Data?,
              let entry = try? JSONDecoder().decode(CacheEntryModel.self, from: cachedData) else {
            return (nil, NetworkError.failureDecoderCache(service.path))
        }

        if entry.isValid(ttl: ttl) {
            let object: T? = entry.decode(to: T.self)
            return (object, nil)
        } else {
            cache.removeObject(forKey: service.path as NSString)
            return (nil, NetworkError.expiredCache(service.path))
        }
    }

    func saveCachedResponse<T: Encodable>(
        _ response: T,
        service: any NetworkLayerServiceType
    ) -> Error? {

        guard shouldCache(service.cache) else {
            return NetworkError.failureSaveCache(service.path)
        }

        do {
            let entry = try CacheEntryModel(response)
            let data = try JSONEncoder().encode(entry)
            cache.setObject(data as NSData, forKey: service.path as NSString)
            return nil
        } catch {
            return NetworkError.custom(error)
        }
    }
}
