//  dateExtension.swift
//  DwitBook

import Foundation

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
}
