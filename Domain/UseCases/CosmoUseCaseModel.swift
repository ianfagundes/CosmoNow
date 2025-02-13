//
//  CosmoUseCaseModel.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import Foundation

struct CosmoUseCaseModel {
    let date: String
    let title: String
    let explanation: String
    let mediaType: MediaType
    let mediaURL: URL?

    init(from model: CosmoModel) {
        self.date = model.date
        self.explanation = model.explanation
        self.mediaType = MediaManager.getMediaType(from: model.mediaType)
        self.title = model.title
        self.mediaURL = MediaManager.getFormattedURL(from: model.url)
    }
}
