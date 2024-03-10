//
//  ProductItem.swift
//  digio
//
//  Created by André  Costa Dantas on 10/03/24.
//

import Foundation

struct ProductItem: Decodable {
    let name: String
    let imageURL: URL
    let description: String
}

extension ProductItem: DetailPresentable {
    var title: String { name }
}
