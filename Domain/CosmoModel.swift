//
//  CosmoModel.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

struct CosmoModel: Codable, Identifiable {
    var id: String { date }
    let date: String
    let explanation: String
    let hdurl: String?
    let mediaType: String
    let serviceVersion: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl, title, url
        case mediaType = "media_type"
        case serviceVersion = "service_version"
    }
}
