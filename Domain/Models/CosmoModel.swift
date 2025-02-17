//
//  CosmoModel.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

struct CosmoModel: Codable, Identifiable, Equatable {
    var id: String { date }
    let date: String
    let explanation: String
    let mediaType: MediaType
    let serviceVersion: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case date, explanation, title, url
        case mediaType = "media_type"
        case serviceVersion = "service_version"
    }
}

enum MediaType: String, Codable {
    case image
    case video
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = MediaType(rawValue: try container.decode(String.self)) ?? .unknown
    }
}

extension CosmoModel {
    init(from useCaseModel: CosmoUseCaseModel) {
        self.date = useCaseModel.date
        self.explanation = useCaseModel.explanation
        self.mediaType = MediaType(rawValue: useCaseModel.mediaType.rawValue) ?? .unknown
        self.serviceVersion = "V1"
        self.title = useCaseModel.title
        self.url = useCaseModel.mediaURL?.absoluteString ?? ""
    }
}
