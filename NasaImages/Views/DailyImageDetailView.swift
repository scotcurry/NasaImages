//
//  DailyImageDetailView.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import SwiftUI

struct DailyImageDetailView: View {
    
    @StateObject private var imageForTheDay = ImageForTheDay()

    let title: String
    let explanation: String
    let urlString: String
    
    var body: some View {
        
        VStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .padding()
            Text(explanation)
                .padding()
            Image(uiImage: imageForTheDay.imageOfTheDay)
                .resizable()
                .frame(width: 200, height: 300, alignment: .topLeading)
                .border(.blue)
                .aspectRatio(contentMode: .fill)
        }
        .task {
            await imageForTheDay.retreiveImageOfTheDay(urlString: urlString)
        }
    }
}

struct DailyImageDetailViewPreview_Previews: PreviewProvider {

    @State static var path = NavigationPath()
    static var imageDay = NasaImageInformation.imageList
    static var title = imageDay[0].title
    static var explanation = imageDay[0].explanation
    static var urlString = imageDay[0].url

    
    static var previews: some View {
        DailyImageDetailView(title: title, explanation: explanation, urlString: urlString)
    }
}
