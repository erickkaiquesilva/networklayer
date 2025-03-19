//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 19/03/25.
//

import XCTest

@testable import NetworkLayer

final class LoggerDecoratorTests: XCTestCase {

    private let loggerHandlerSpy: LoggerHandlerSpy = .init()
    private let networkSpy: NetworkLayerRequestSpy = .init()
    private lazy var sut: LoggerDecorator = .init(
        network: networkSpy,
        handler: loggerHandlerSpy
    )

    func test_request_withCompletionResultReturnedData() {
        // Given
        let dummyRequest: any NetworkLayerServiceType = NetworkLayerServiceMock()

        // When
        sut.request(service: dummyRequest, completion: { _ in })

        // Then
        XCTAssertEqual(networkSpy.requestWithDataResultCount, 1)
        XCTAssertEqual(networkSpy.requestServiceWithDataResult?.path, dummyRequest.path)
        XCTAssertEqual(networkSpy.requestServiceWithDataResult?.cache, dummyRequest.cache)
        XCTAssertEqual(networkSpy.requestServiceWithDataResult?.header, dummyRequest.header)
        XCTAssertEqual(networkSpy.requestServiceWithDataResult?.httpMethod, dummyRequest.httpMethod)
        XCTAssertNil(networkSpy.requestServiceWithDataResult?.body)
        XCTAssertEqual(loggerHandlerSpy.logRequestWithDataCount, 1)
        XCTAssertEqual(loggerHandlerSpy.logRequestWithDataService?.path, dummyRequest.path)
        XCTAssertEqual(loggerHandlerSpy.logRequestWithDataService?.cache, dummyRequest.cache)
        XCTAssertEqual(loggerHandlerSpy.logRequestWithDataService?.header, dummyRequest.header)
        XCTAssertEqual(loggerHandlerSpy.logRequestWithDataService?.httpMethod, dummyRequest.httpMethod)
    }

    func test_request_withCompletionResultReturnedGenricTypeCodable() {
        // Given
        let dummyRequest: any NetworkLayerServiceType = NetworkLayerServiceMock()

        // When
        sut.request(object: ObjectMock.self, service: dummyRequest, completion: { _ in })

        // Then
        XCTAssertEqual(networkSpy.requestWithCodableResultCount, 1)
        XCTAssertEqual(networkSpy.requestServiceWithCodableResult?.path, dummyRequest.path)
        XCTAssertEqual(networkSpy.requestServiceWithCodableResult?.cache, dummyRequest.cache)
        XCTAssertEqual(networkSpy.requestServiceWithCodableResult?.header, dummyRequest.header)
        XCTAssertEqual(networkSpy.requestServiceWithCodableResult?.httpMethod, dummyRequest.httpMethod)
        XCTAssertNil(networkSpy.requestServiceWithCodableResult?.body)
        XCTAssertEqual(loggerHandlerSpy.logRequestWithCodableCount, 1)
        XCTAssertEqual(loggerHandlerSpy.logRequestWithCodableService?.path, dummyRequest.path)
        XCTAssertEqual(loggerHandlerSpy.logRequestWithCodableService?.cache, dummyRequest.cache)
        XCTAssertEqual(loggerHandlerSpy.logRequestWithCodableService?.header, dummyRequest.header)
        XCTAssertEqual(loggerHandlerSpy.logRequestWithCodableService?.httpMethod, dummyRequest.httpMethod)
    }
}
