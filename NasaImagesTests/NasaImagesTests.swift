//
//  NasaImagesTests.swift
//  NasaImagesTests
//
//  Created by Scot Curry on 1/13/24.
//

import XCTest
@testable import NasaImages

final class NasaImagesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testGetListOfImageDays() async throws {
        
        let startDate = Date.now
        let dataHandler = NasaApiHandler()
        let returnData = try await dataHandler.retrieveListOfImages(startDate: startDate)
        let url = returnData[0].url
        let startsWithRightInfo = url.hasPrefix("https://")
        XCTAssert(startsWithRightInfo)
    }
    
    func testGetDailyImage() async throws {
        
        let urlImageString = "https://apod.nasa.gov/apod/image/2401/ThorsHelmet_Biswas_960.jpg"
        let imageDownloader = ImageDownloadHandler()
        let umImage = try await imageDownloader.retrieveImageFromUrl(urlString: urlImageString)
        XCTAssertNotNil(umImage)
    }
}
