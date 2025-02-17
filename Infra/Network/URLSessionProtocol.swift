//
//  URLSessionProtocol.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 17/02/25.
//

import Foundation
protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
