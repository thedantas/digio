//
//  DigioStoreRepository.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

protocol DigioStoreRepository {
    /**
     # DigioStoreRepository

     This protocol defines methods for fetching data related to the Digio Store.

     ## Methods

     - `getStore(onComplete:)`: Fetches store data including spotlight items,
       product items, and cash item.

       - Parameters:
         - onComplete: A completion handler that returns a result containing
           `DigioStoreResponse` on success or a `ResponseError` on failure.
           The `DigioStoreResponse` includes arrays of `SpotlightItem` and
           `ProductItem`, and a single `CashItem`.
     */
    func getStore(onComplete: @escaping (Result<DigioStoreEntity, ResponseError>) -> Void)
}
