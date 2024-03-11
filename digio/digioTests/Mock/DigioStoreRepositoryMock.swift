//
//  DigioStoreRepositoryMock.swift
//  digioTests
//
//  Created by André  Costa Dantas on 10/03/24.
//

import Foundation
@testable import digio

class DigioStoreRepositoryMock: DigioStoreRepository {
    var shouldReturnError: Bool
    var testSpotlightItems: [SpotlightItem]
    var testProductItems: [ProductItem]
    var testCashItem: CashItem

    init(shouldReturnError: Bool, testSpotlightItems: [SpotlightItem], testProductItems: [ProductItem], testCashItem: CashItem) {
        self.shouldReturnError = shouldReturnError
        self.testSpotlightItems = testSpotlightItems
        self.testProductItems = testProductItems
        self.testCashItem = testCashItem
    }

    func getStore(onComplete: @escaping (Result<DigioStoreEntity, ResponseError>) -> Void) {
        if shouldReturnError {
            onComplete(.failure(ResponseError(description: "Network error", statusCode: 500)))
        } else {
            let response = DigioStoreEntity(spotlight: testSpotlightItems, products: testProductItems, cash: testCashItem)
            onComplete(.success(response))
        }
    }
}

