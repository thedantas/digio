//
//  DetailPresentable+Protocol.swift
//  digio
//
//  Created by André  Costa Dantas on 10/03/24.
//

import Foundation

protocol DetailPresentable {
    var title: String { get }
    var imageURL: URL { get }
    var description: String { get }
}

extension CashItem: DetailPresentable {
    var imageURL: URL { bannerURL }
}
