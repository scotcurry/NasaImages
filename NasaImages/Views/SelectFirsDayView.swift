//
//  ContentView.swift
//  NasaImages
//
//  Created by Scot Curry on 1/13/24.
//

import SwiftUI

struct SelectFirsDayView: View {
    
    @State private var date = Date()
    @State var path = NavigationPath()
       
    let validDateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponent = DateComponents(year: 2023, month: 1, day: 1)
        let startDate = calendar.date(from: startComponent)
        return (startDate ?? Date.now)...(Date.now)
    }()
    let startDate = Date.now
   
    var body: some View {
       
        NavigationStack {
            VStack {
                DatePicker(
                   "Start Date",
                   selection: $date,
                   in: validDateRange,
                   displayedComponents: [.date]
               )
               .padding()
               .datePickerStyle(.compact)
               .labelsHidden()
               
               NavigationLink("First Day Image") {
                   DailyImageListView(path: $path, startDate: $date)
               }
           }
       }
   }
}

#Preview {
    SelectFirsDayView()
}
