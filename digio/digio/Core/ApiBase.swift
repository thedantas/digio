//
//  ApiBase.swift
//  digio
//
//  Created by André  Costa Dantas on 09/03/24.
//

import Foundation

enum ApiMethod: String {
    case get = "GET"
    case post = "POST"
}

class ApiBase {
    private let baseUrl = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/"

    var apiMethod: ApiMethod = .get
    var apiPath: String = ""
    var params: [String: Any] = [:]
    var headers: [String: String] = [:]

    func request(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlString = "\(baseUrl)/\(apiPath)"
        guard let url = URL(string: urlString) else {
            completion(nil, nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = apiMethod.rawValue

        if apiMethod == .post, let postData = try? JSONSerialization.data(withJSONObject: params, options: []) {
            request.httpBody = postData
            headers["Content-Type"] = "application/json"
        }

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
}

