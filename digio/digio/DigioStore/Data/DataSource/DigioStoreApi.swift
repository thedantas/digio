//
//  DigioStoreApi.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation

class DigioStoreApi: ApiBase {

    static func getProducts() -> DigioStoreApi {
        let api = DigioStoreApi()
        api.apiMethod = .get
        api.apiPath = "products"

        return api
    }
}
