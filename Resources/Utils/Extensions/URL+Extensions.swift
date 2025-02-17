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
            print("URL inválida detectada")
            return URL(string: "https://api.nasa.gov/planetary/apod")!
        }
        return url
    }
}
