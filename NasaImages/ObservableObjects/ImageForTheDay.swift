//
//  ImageForTheDay.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import Foundation
import UIKit
import OSLog

@MainActor
class ImageForTheDay: ObservableObject {
    
    @Published private(set) var imageOfTheDay: UIImage = UIImage()
    
    func retreiveImageOfTheDay(urlString: String) async {
        
        let logger = Logger(subsystem: "org.curryware.nasaImages", category: "ImageForTheDay_Object")
        logger.debug("Attempting to get image: \(urlString)")
        let imageDownloader = ImageDownloadHandler()
        do {
            logger.debug("Calling ImageDownloadHandler from ImageForTheDay")
            logger.debug("URL String: \(urlString)")
            let uiImage: UIImage = try await imageDownloader.retrieveImageFromUrl(urlString: urlString)
            imageOfTheDay = uiImage
        } catch URLError.cancelled {
            print("URL Error Code")
        } catch {
            logger.error("Error message")
            print(error)
        }
    }
}
