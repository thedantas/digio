//
//  ResponseError.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation

struct ResponseError: Error {
    var description: String
    var statusCode: Int = 0
}
