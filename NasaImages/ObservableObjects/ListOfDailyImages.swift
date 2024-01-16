//
//  ListOfDailyImages.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import Foundation
import OSLog

@MainActor
class ListOfDailyImages: ObservableObject {
    
    @Published private(set) var listOfDailyImages: [NasaImageInformation] = []
    
    func retreiveListOfImages(startDate: Date) async {
        let logger = Logger(subsystem: "org.curryware.nasaImages.ListOfDailyImages", category: "retreiveListOfImages")
        let nasaAPIHandler = NasaApiHandler()
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .full
            let timeToDisplay = dateFormatter.string(from: Date.now)
            logger.debug("Calling listOfDailyImages - Time: \(timeToDisplay)")
            listOfDailyImages = try await nasaAPIHandler.retrieveListOfImages(startDate: startDate)
        } catch {
            print(error)
        }
    }
}
