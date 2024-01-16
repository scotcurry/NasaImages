//
//  ImageDownloadHandler.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import Foundation
import UIKit
import OSLog

struct ImageDownloadHandler {
    
    func retrieveImageFromUrl(urlString: String) async throws -> UIImage {
        
        let logger = Logger(subsystem: "org.curryware.nasaImages.ImageDownloadHandler", category: "retreiveImageFromUrl")
        logger.debug("GET: \(urlString)")
        var uiImage: UIImage = UIImage()
        
        if let url = URL(string: urlString) {
            logger.debug("ImageDownloadHandler URL: \(url.formatted())")
            let imageUrlRequest = URLRequest(url: url)
            logger.debug("Created imageUrlRequest \(imageUrlRequest.debugDescription)")
            let validRange = 200...299
            do {
                logger.debug("Getting ready to build Imagedownloader URL Session")
                let (data, response) = try await URLSession.shared.data(for: imageUrlRequest)
                guard let httpResponse = response as? HTTPURLResponse,
                      validRange ~= httpResponse.statusCode else {
                    print("Invalid Response Error")
                    throw HTTPResponseError.invalidResponse
                }
                if let uiImageToCheck = UIImage(data: data) {
                    uiImage = uiImageToCheck
                    logger.debug("Returning a valid image!")
                    return uiImage
                }
            } catch URLError.cancelled {
                return uiImage
            }
        }
        return uiImage
    }
}
