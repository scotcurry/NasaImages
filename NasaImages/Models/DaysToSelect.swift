//
//  DaysToSelect.swift
//  NasaImages
//
//  Created by Scot Curry on 1/18/24.
//

import Foundation

struct DaysToSelect: Identifiable, Hashable {
    
    var id: UUID
    let dateValue: Date
    let dateString: String
    
    init(id: UUID = UUID(), dateValue: Date, dateString: String) {
        self.id = id
        self.dateValue = dateValue
        self.dateString = dateString
    }
}

extension DaysToSelect {
    
    static var listOfDaysToSelect: [DaysToSelect] = {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY/MM/dd"
        let currentDate = Date.now
        let dateString1 = dateFormatter.string(from: currentDate)
        
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date.now)
        let dateString2 = dateFormatter.string(from: yesterday!)
        
        let listOfDays = [
            DaysToSelect(dateValue: currentDate, dateString: dateString1),
            DaysToSelect(dateValue: yesterday!, dateString: dateString2)
        ]
        return listOfDays
    }()
}
