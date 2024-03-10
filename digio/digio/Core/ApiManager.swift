//
//  ApiManager.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation

struct ApiManager {
    func request<T: Decodable>(api: ApiBase, type: T.Type, onComplete: @escaping (Result<T, ResponseError>) -> Void) {
        api.request { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                onComplete(.failure(ResponseError(description: "Invalid response")))
                return
            }

            if let data = data, error == nil {
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    if httpResponse.statusCode == 200 {
                        onComplete(.success(model))
                    } else {
                        onComplete(.failure(ResponseError(description: "Error status code: \(httpResponse.statusCode)")))
                    }
                } catch {
                    onComplete(.failure(ResponseError(description: error.localizedDescription)))
                }
            } else if let error = error {
                onComplete(.failure(ResponseError(description: error.localizedDescription)))
            } else {
                onComplete(.failure(ResponseError(description: "Unknown error occurred")))
            }
        }
    }
}
