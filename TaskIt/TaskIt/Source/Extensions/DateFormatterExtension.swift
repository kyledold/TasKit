//
//  DateFormatterExtension.swift
//  TaskIt
//
//  Created by Kyle Dold on 21/03/2021.
//

import Foundation

extension DateFormatter {
    
    static var monthDateFormatter: DateFormatter {
        let monthDateFormatter = DateFormatter()
        monthDateFormatter.dateFormat = "MMM"
        return monthDateFormatter
    }
    
    static var dayOfWeekDateFormatter: DateFormatter {
        let dayOfWeekDateFormatter = DateFormatter()
        dayOfWeekDateFormatter.dateFormat = "EEE"
        return dayOfWeekDateFormatter
    }
    
    static var shortDateDateFormatter: DateFormatter {
        let shortDateDateFormatter = DateFormatter()
        shortDateDateFormatter.dateFormat = "EEE dd MMMM"
        return shortDateDateFormatter
    }
    
    static var shortTimeDateFormatter: DateFormatter {
        let shortDateDateFormatter = DateFormatter()
        shortDateDateFormatter.dateFormat = "HH:mm"
        return shortDateDateFormatter
    }
}
