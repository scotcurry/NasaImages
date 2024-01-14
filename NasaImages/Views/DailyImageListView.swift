//
//  DailyImageListView.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import SwiftUI

struct DailyImageListView: View {
    
    let imageList: [NasaImageInformation]
    var body: some View {
        NavigationStack {
            List {
                ForEach(imageList) { listItem in
                    NavigationLink(listItem.title, value: listItem)
                }
            }
            Text("Total Days: \(imageList.count)")
            .navigationTitle("Daily Images")
            .navigationDestination(for: NasaImageInformation.self) { listItem in DailyImageDetailView(dailyImageInfo: listItem)
            }
        }
    }
}

struct DailyImageListViewPreview_Previews: PreviewProvider {
    
    static var imageList = NasaImageInformation.imageList
    
    static var previews: some View {
        DailyImageListView(imageList: imageList)
    }
}
