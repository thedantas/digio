//
//  DIExtension.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation
import Swinject

func getService<T>(_ serviceType: T.Type) -> T? {
    return Assembler.sharedAssembler.resolver.resolve(serviceType)
}
