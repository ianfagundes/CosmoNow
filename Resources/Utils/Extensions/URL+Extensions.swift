//
//  URL+Extensions.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import Foundation

extension URL {
    static var nasaCosmoURL: URL {
        guard let url = URL(string: APIConfig.baseURL) else {
            fatalError("URL inválida: Verifique `APIConfig.baseURL`")
        }
        return url
    }
}
