//
//  ListOfDailyImages.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import Foundation

class ListOfDailyImages: ObservableObject {
    
    @Published private(set) var listOfDailyImages: [NasaImageInformation] = []
    
    func retreiveListOfImages(startDate: Date) async {
        let nasaAPIHandler = NasaApiHandler()
        do {
            listOfDailyImages = try await nasaAPIHandler.retrieveListOfImages(startDate: startDate)
        } catch {
            print(error)
        }
    }
}
