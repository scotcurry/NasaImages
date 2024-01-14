//
//  ImageDownloadHandler.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import Foundation
import UIKit

struct ImageDownloadHandler {
    
    func retrieveImageFromUrl(urlString: String) async throws -> UIImage {
        
        var uiImage: UIImage = UIImage()
        
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            let validRange = 200...299
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse,
                  validRange ~= httpResponse.statusCode else {
                print("Invalid Response Error")
                throw HTTPResponseError.invalidResponse
            }
            if let uiImageToCheck = UIImage(data: data) {
                uiImage = uiImageToCheck
                return uiImage
            }
        }
        return uiImage
    }
}
