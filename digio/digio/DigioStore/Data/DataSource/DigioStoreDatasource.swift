//
//  DigioStoreDatasource.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation

protocol DigioStoreDatasource {
    func getDigioStore(onComplete: @escaping (Result<DigioStoreEntity, ResponseError>) -> Void)

}

class DigioStoreDatasourceImpl: DigioStoreDatasource {
    func getDigioStore(onComplete: @escaping (Result<DigioStoreEntity, ResponseError>) -> Void) {
        let api = DigioStoreApi.getProducts()
        ApiManager().request(api: api, type: DigioStoreEntity.self) { result in
            switch result {
            case .success(let response):
                onComplete(.success(response))
            case .failure(let error):
                let responseError = ResponseError(description: error.localizedDescription)
                onComplete(.failure(responseError))
            }
        }
    }
}
