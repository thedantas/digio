//
//  digioTests.swift
//  digioTests
//
//  Created by André  Costa Dantas on 09/03/24.
//

import XCTest
@testable import digio

final class DigioTests: XCTestCase {

    func testFetchStoreDataSuccess() {
        let spotlightMock = [
            SpotlightItem(
                name: "Spotlight Test",
                bannerURL: URL(string: "http://example.com/spotlight")!,
                description: "Description Test"
            )
        ]
        let productMock = [
            ProductItem(
                name: "Product Test",
                imageURL: URL(string: "http://example.com/product")!,
                description: "Bla Bla"
            )
        ]
        let cashMock = CashItem(
            title: "Cash Test",
            bannerURL: URL(string: "http://example.com/cash")!,
            description: "Cash Description Test"
        )

        let repositoryMock = DigioStoreRepositoryMock(
            shouldReturnError: false,
            testSpotlightItems: spotlightMock,
            testProductItems: productMock,
            testCashItem: cashMock
        )

        let viewModel = DigioStoreViewModel(repository: repositoryMock)

        let expectation = XCTestExpectation(
            description: "Fetch store data successfully updates the view model properties"
        )

        viewModel.fetchStoreData { isSuccess, error in
            XCTAssertTrue(isSuccess)
            XCTAssertNil(error)
            XCTAssertEqual(viewModel.spotlightItems.count, spotlightMock.count)
            XCTAssertEqual(viewModel.productItems.count, productMock.count)
            XCTAssertNotNil(viewModel.cashItem)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchStoreDataFailure() {
        let repositoryMock = DigioStoreRepositoryMock(
            shouldReturnError: true,
            testSpotlightItems: [],
            testProductItems: [],
            testCashItem: CashItem(
                title: "",
                bannerURL: URL(string: "http://example.com")!,
                description: ""
            )
        )

        let viewModel = DigioStoreViewModel(repository: repositoryMock)

        let expectation = XCTestExpectation(description: "Fetch store data failure correctly handles the error")

        viewModel.fetchStoreData { isSuccess, error in
            XCTAssertFalse(isSuccess)
            XCTAssertNotNil(error)
            XCTAssertTrue(viewModel.spotlightItems.isEmpty)
            XCTAssertTrue(viewModel.productItems.isEmpty)
            XCTAssertNil(viewModel.cashItem)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
