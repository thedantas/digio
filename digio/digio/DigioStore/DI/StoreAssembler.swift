//
//  StoreAssembler.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation
import Swinject

class StoreAssembler: Assembly {
    func assemble(container: Container) {

        container.register(DigioStoreDatasource.self) { _ in
            DigioStoreDatasourceImpl()}

        container.register(DigioStoreRepository.self) { _ in
            DigioStoreRepositoryImpl(dataSource: getService(DigioStoreDatasource.self)!)}
            
    }
}
