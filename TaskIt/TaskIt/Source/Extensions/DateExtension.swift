//
//  DateExtension.swift
//  TaskIt
//
//  Created by Kyle Dold on 23/02/2021.
//

import Foundation

extension Date {
    
    var month: String { return DateFormatter.monthDateFormatter.string(from: self) }
    
    var dayOfTheWeek: String { return DateFormatter.dayOfWeekDateFormatter.string(from: self) }
    
    var shortDate: String { return DateFormatter.shortDateDateFormatter.string(from: self) }

    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func addDays(numberOfDays: Int) -> Date {
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = 1
        return Calendar.current.date(byAdding: dateComponent, to: currentDate)!
    }
}

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
}
