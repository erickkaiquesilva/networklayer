//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 19/03/25.
//

import XCTest

@testable import NetworkLayer

final class LoggerHandlerTests: XCTestCase {

    // MARK: - Prorperties

    private let delegateSpy: NetworkLayerDelegateSpy = .init()
    private lazy var sut: LoggerHandler = LoggerHandler(delegate: delegateSpy)

    func test_logRequest_whenResultIsSuccess() {
        // Given
        let dummyService: NetworkLayerServiceType = NetworkLayerServiceMock()
        let dummyResultWithSuccess: Result<Data, Error> = ResultMock.mockSuccessResult()

        // When
        sut.logRequest(service: dummyService, result: dummyResultWithSuccess)
    }

    func test_logRequest_whenResultIsFailure() {
        // Given
        let dummyService: NetworkLayerServiceType = NetworkLayerServiceMock()
        let dummyResultWithFailure: Result<Data, Error> = ResultMock.mockFailureResult()

        // When
        sut.logRequest(service: dummyService, result: dummyResultWithFailure)
    }

    func test_logRequest_whenResultIsSuccess_whenResultReturnObjectGenericTypeCodable() {
        // Given
        let dummyService: NetworkLayerServiceType = NetworkLayerServiceMock()
        let dummyResultWithSuccess = ResultMock.mockSuccessResultCodable()

        // When
        sut.logRequest(service: dummyService, result: dummyResultWithSuccess)
    }

    func test_logRequest_whenResultIsFailure_whenResultReturnObjectGenericTypeCodable() {
        // Given
        let dummyService: NetworkLayerServiceType = NetworkLayerServiceMock()
        let dummyResultWithFailure = ResultMock.mockFailureResultCodable()

        // When
        sut.logRequest(service: dummyService, result: dummyResultWithFailure)
    }
    
}
