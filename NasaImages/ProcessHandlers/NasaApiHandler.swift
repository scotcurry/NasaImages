//
//  NasaApiHandler.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import Foundation

struct NasaApiHandler {
    
    func retrieveListOfImages(startDate: Date) async throws -> [NasaImageInformation] {
        
        var nasaApiDataListItems: [NasaImageInformation] = []
        if let builtURL = buildApiUrl(imageDate: startDate) {
            let urlRequest = URLRequest(url: builtURL)
            let validRange = 200...299
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, validRange ~= httpResponse.statusCode else {
                print("Invalid HTTP Response")
                throw HTTPResponseError.invalidResponse
            }
            if let apiData = parseReturnedJson(jsonData: data) {
                // Some lazy code here.  Don't want to deal with the optionals that are a result of the JSON parsing, so
                // there is another
                let identifiableData = buildImageList(nasaApiData: apiData)
                nasaApiDataListItems = identifiableData
                return nasaApiDataListItems
            }
        }
        return nasaApiDataListItems
    }
    
    // Some lazy code here.
    private func parseReturnedJson(jsonData: Data) -> [NasaApiData]? {
        
        do {
            let nasaApiData: [NasaApiData] = try JSONDecoder().decode([NasaApiData].self, from: jsonData)
            return nasaApiData
        } catch let jsonError {
            print("JSON Parsing Error: \(jsonError)")
        }
        return nil
    }
    
    // Don't want to deal with the optional values in the JSON data, so build a new list where there are no optionals.
    private func buildImageList(nasaApiData: [NasaApiData]) -> [NasaImageInformation] {
        
        var apiImageDataList: [NasaImageInformation] = []
        for currentApiData in nasaApiData {
            let id = UUID()
            let dataToAppend = NasaImageInformation(id: id, dateString: currentApiData.dateString , explanation: currentApiData.explanation,
                                                   media_type: currentApiData.media_type, service_version: currentApiData.service_version,
                                                   title: currentApiData.title, url: currentApiData.url)
            apiImageDataList.append(dataToAppend)
        }
        return apiImageDataList
    }
    
    // Nothing interesting here.  Just building the URL from the components.  Still need to figure out work with the secret.
    private func buildApiUrl(imageDate: Date) -> URL? {
        
        let firstDateString = getStringsFromDate(imageDate).firstDay
        let lastDateString = getStringsFromDate(imageDate).lastDay
        let apiKey = getApiKey()
        
        let queryItemFirstDay = URLQueryItem(name: "start_date", value: firstDateString)
        let queryItemLastDay = URLQueryItem(name: "end_date", value: lastDateString)
        let queryItemApiKey = URLQueryItem(name: "api_key", value: apiKey)
        var allQueryItems: [URLQueryItem] = []
        allQueryItems.append(queryItemApiKey)
        allQueryItems.append(queryItemLastDay)
        allQueryItems.append(queryItemFirstDay)
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = "/planetary/apod"
        components.queryItems = allQueryItems
        return components.url
    }
    
    // This creates a dates that are going to be passed to the API.
    private func getStringsFromDate(_ imageDate: Date) -> (firstDay: String, lastDay: String) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let lastDateString = dateFormatter.string(from: imageDate)
        
        let firstDate = Calendar.current.date(byAdding: .day, value: -5, to: imageDate)
        let firstDateString = dateFormatter.string(from: firstDate!)
        return (firstDateString, lastDateString)
    }
    
    // Since the API key is stored in a secret file that isn't stored in git, pull the value out of the
    // xcconfig file.
    private func getApiKey() -> String? {
        
        if let apiKey = Bundle.main.infoDictionary?["NASA_API_KEY"] as? String {
            return apiKey
        }
        return "Unable to Access API Key"
    }}
