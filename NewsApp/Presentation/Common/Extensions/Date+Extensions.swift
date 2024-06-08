//
//  Date+Extensions.swift
//  NewsApp
//
//  Created by Amr Magdy on 08/06/2024.
//

import Foundation

extension Date {
    static func from(_ string: String, format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)
    }
    
    func formattedDate() -> String {
           let formatter = DateFormatter()
           formatter.dateStyle = .medium
           formatter.timeStyle = .short
           return formatter.string(from: self)
       }
}
