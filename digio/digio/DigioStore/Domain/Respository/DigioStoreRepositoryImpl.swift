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
    var friendsReferral: [DigioStoreResponse]

    init(dataSource: DigioStoreDatasource) {
        self.dataSource = dataSource
        self.friendsReferral = []
    }

    func getStore(onComplete: @escaping (Result<DigioStoreResponse, ResponseError>) -> Void) {
        dataSource.getDigioStore { [weak self] result in
            switch result {
            case let .success(responses):
                let friendReferrals = responses

                onComplete(.success(friendReferrals))
            case .failure:
                onComplete(.failure(ResponseError(description: "default_error_message".localization())))
            }
        }
    }

}

