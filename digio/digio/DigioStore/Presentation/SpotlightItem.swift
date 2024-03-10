//
//  SpotlightItem.swift
//  digio
//
//  Created by André  Costa Dantas on 10/03/24.
//

import Foundation

struct SpotlightItem: Decodable {
    let name: String
    let bannerURL: URL
    let description: String
}

extension SpotlightItem: DetailPresentable {
    var title: String { name }
    var imageURL: URL { bannerURL }
}
