//
//  NasaImageInformation.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import Foundation

struct NasaImageInformation: Identifiable, Hashable {
    
    var id: UUID
    let dateString: String
    let explanation: String
    let media_type: String
    let service_version: String
    let title: String
    let url: String
    
    init(id: UUID = UUID(), dateString: String, explanation: String, media_type: String, service_version: String, title: String, url: String) {
        self.id = id
        self.dateString = dateString
        self.explanation = explanation
        self.media_type = media_type
        self.service_version = service_version
        self.title = title
        self.url = url
    }
}

extension NasaImageInformation {
    
    static var imageList: [NasaImageInformation] {
        [
            NasaImageInformation(id: UUID(), dateString: "2024-01-13", explanation: "First Explanation", media_type: "media_type", service_version: "service_version", title: "First Title", url: "https://www.espn.com"),
            NasaImageInformation(id: UUID(), dateString: "2024-01-12", explanation: "Second Explanation", media_type: "media_type", service_version: "service_version", title: "First Title", url: "https://www.cnn.com")
        ]
    }
}
