//
//  HttpErrorEnum.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import Foundation


enum HTTPResponseError: Error {
    
    case invalidResponse
    case noApiUrl
    case imageLoadError
}
