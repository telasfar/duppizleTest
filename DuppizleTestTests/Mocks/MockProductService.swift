//
//  MockProductService.swift
//  DuppizleTest
//
//  Created by Tariq Maged on 14/11/2021.
//

import Foundation
import Foundation
import Combine
@testable import DuppizleTest

final class MockProductService: ProductServiceProtocol {
    
    var getCallsCount: Int = 0

    var getResult: Result<ProductModel, Error> = .success(ProductModel(results:[]))

    func getProducts() -> AnyPublisher<ProductModel, Error> {
        getCallsCount += 1

        return getResult.publisher.eraseToAnyPublisher()
    }
}
