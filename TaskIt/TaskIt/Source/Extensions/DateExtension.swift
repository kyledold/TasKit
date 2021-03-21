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
    
    public func setTime(hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let calendar = Calendar.current
        var components = calendar.dateComponents(x, from: self)

        components.hour = hour
        components.minute = minute
        components.second = second

        return calendar.date(from: components)!
    }
}
