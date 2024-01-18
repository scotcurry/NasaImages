//
//  DailyImageListView.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import SwiftUI
import OSLog

struct DailyImageListView: View {
    
    @Binding var path: NavigationPath
    @Binding var startDate: Date
    @StateObject private var listOfDailyImages = ListOfDailyImages()
    
    let logger = Logger()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(listOfDailyImages.listOfDailyImages) { listItem in
                NavigationLink(listItem.title, value: listItem)
            }
            .navigationTitle("Daily Images")
            .navigationDestination(for: NasaImageInformation.self) { listItem in 
                DailyImageDetailView(title: listItem.title, explanation: listItem.explanation, urlString: listItem.url)
            }
            Text("Total Days: \(listOfDailyImages.listOfDailyImages.count)")
        }
        .onAppear {
            Task {
                print("Calling onAppear")
                await listOfDailyImages.retreiveListOfImages(startDate: startDate)
            }
        }
    }
}

struct DailyImageListViewPreview_Previews: PreviewProvider {
    
    @State static var startDate = Date.now
    @State static var path = NavigationPath()
    
    static var previews: some View {
        DailyImageListView(path: $path, startDate: $startDate)
    }
}
