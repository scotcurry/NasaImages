//
//  NasaApiData.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import Foundation

struct NasaApiData: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case copyright, explanation, hdurl, media_type, service_version, title, url, dateString = "date"
    }
    
    let copyright: String?
    let dateString: String
    let explanation: String
    let hdurl: URL?
    let media_type: String
    let service_version: String
    let title: String
    let url: String
}
