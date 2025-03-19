//
//  File.swift
//  NetworkLayer
//
//  Created by Erick Silva on 19/03/25.
//

import Foundation

final class ResultMock {

    static func mockSuccessResult() -> Result<Data, any Error> {
        let jsonString = """
            {
                "id": 1,
                "title": "Teste Mock",
                "status": "success"
            }
            """
        let data = jsonString.data(using: .utf8)!
        return .success(data)
    }

    static func mockSuccessResultCodable() -> Result<ObjectMock, any Error> {
        let objectMock: ObjectMock = .init(id: 1, name: "dummy-name", year: "28")
        return .success(objectMock)
    }

    static func mockFailureResult() -> Result<Data, any Error> {
        let error = NSError(domain: "com.example.test", code: -1, userInfo: [
            NSLocalizedDescriptionKey: "Erro simulado para teste"
        ])
        return .failure(error)
    }

    static func mockFailureResultCodable() -> Result<ObjectMock, any Error> {
        let error = NSError(domain: "com.example.test", code: -1, userInfo: [
            NSLocalizedDescriptionKey: "Erro simulado para teste"
        ])
        return .failure(error)
    }
}
