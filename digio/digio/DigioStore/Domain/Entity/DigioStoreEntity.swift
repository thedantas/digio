//
//  DigioStoreEntity.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation

struct SpotlightItem: Decodable {
    let name: String
    let bannerURL: URL
    let description: String
}

struct ProductItem: Decodable {
    let name: String
    let imageURL: URL
    let description: String
}

struct CashItem: Decodable {
    let title: String
    let bannerURL: URL
    let description: String
}

struct DigioStoreResponse: Decodable {
    let spotlight: [SpotlightItem]
    let products: [ProductItem]
    let cash: CashItem
}


extension SpotlightItem: DetailPresentable {
    var title: String { name }
    var imageURL: URL { bannerURL }
}

extension ProductItem: DetailPresentable {
    var title: String { name }
}

extension CashItem: DetailPresentable {
    var imageURL: URL { bannerURL }
}
