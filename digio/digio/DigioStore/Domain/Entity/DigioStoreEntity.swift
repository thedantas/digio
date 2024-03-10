//
//  DigioStoreEntity.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation

struct DigioStoreEntity: Decodable {
    let spotlight: [SpotlightItem]
    let products: [ProductItem]
    let cash: CashItem
}
