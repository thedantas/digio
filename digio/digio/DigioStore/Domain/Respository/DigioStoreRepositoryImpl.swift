//
//  DigioStoreRepositoryImpl.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation

class DigioStoreRepositoryImpl: DigioStoreRepository {

    // MARK: - Properties
    private let dataSource: DigioStoreDatasource
    var digioStore: [DigioStoreEntity]

    init(dataSource: DigioStoreDatasource) {
        self.dataSource = dataSource
        self.digioStore = []
    }

    func getStore(onComplete: @escaping (Result<DigioStoreEntity, ResponseError>) -> Void) {
        dataSource.getDigioStore { [weak self] result in
            switch result {
            case let .success(responses):
                onComplete(.success(responses))
            case .failure:
                onComplete(.failure(ResponseError(description: "default_error_message".localization())))
            }
        }
    }
}
