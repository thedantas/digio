//
//  DigioStoreViewModel.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation

class DigioStoreViewModel {
    let repository = getService(DigioStoreRepository.self)!
    var spotlightItems: [SpotlightItem] = []
    var productItems: [ProductItem] = []
    var cashItem: CashItem?

    func fetchStoreData(completion: @escaping (Bool, ResponseError?) -> Void) {
        repository.getStore { [weak self] result in
            switch result {
            case .success(let storeResponse):
                self?.spotlightItems = storeResponse.spotlight
                self?.productItems = storeResponse.products
                self?.cashItem = storeResponse.cash
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
}
