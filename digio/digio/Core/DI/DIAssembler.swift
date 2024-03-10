//
//  DIAssembler.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation
import Swinject

extension Assembler {

    static let container: Container = {
        Container()
    }()

    static let sharedAssembler: Assembler = {
        Assembler([
            StoreAssembler()
        ], container: container)
    }()
}
