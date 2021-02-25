//
//  Formatter.swift
//  RA_Swift
//
//  Created By"Shiv Mohan Singh" on 25/10/17.
//  Copyright © 2017 Bruce. All rights reserved.
//

import Foundation
extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        return formatter
    }()
}


