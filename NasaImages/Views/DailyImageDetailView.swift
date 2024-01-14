//
//  DailyImageDetailView.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import SwiftUI

struct DailyImageDetailView: View {
    
    let dailyImageInfo: NasaImageInformation
    
    var body: some View {
        VStack {
            Text(dailyImageInfo.title)
            Text(dailyImageInfo.explanation)
        }
    }
}

struct DailyImageDetailViewPreview_Previews: PreviewProvider {

    static var imageDay = NasaImageInformation.imageList
    
    static var previews: some View {
        DailyImageDetailView(dailyImageInfo: imageDay[0])
    }
}
