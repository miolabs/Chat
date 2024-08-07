//
//  Utils.swift
//  ChatFirestoreExample
//
//  Created by Alisa Mylnikova on 19.06.2023.
//

import SwiftUI

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}

extension View {
    func font(_ size: CGFloat, _ color: Color = .black, _ weight: Font.Weight = .regular) -> some View {
        self
            .fontWeight(weight)
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension String {
    func toURL() -> URL? {
        URL(string: self)
    }
}

extension Date {
    func timeAgoFormat(numericDates: Bool = false) -> String {
        let calendar = Calendar.current
        let date = self
        let now = Date()
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if components.year! >= 2 {
            return String(localized: "\(components.year!) years ago")
        } else if components.year! >= 1 {
            if numericDates {
                return String(localized: "1 year ago")
            } else {
                return String(localized: "Last year")
            }
        } else if components.month! >= 2 {
            return String(localized: "\(components.month!) months ago")
        } else if components.month! >= 1 {
            if numericDates {
                return String(localized: "1 month ago")
            } else {
                return String(localized: "Last month")
            }
        } else if components.weekOfYear! >= 2 {
            return String(localized: "\(components.weekOfYear!) weeks ago")
        } else if components.weekOfYear! >= 1 {
            if numericDates {
                return String(localized: "1 week ago")
            } else {
                return String(localized: "Last week")
            }
        } else if components.day! >= 2 {
            return String(localized: "\(components.day!) days ago")
        } else if components.day! >= 1 {
            if numericDates {
                return String(localized: "1 day ago")
            } else {
                return String(localized: "Yesterday")
            }
        } else if components.hour! >= 2 {
            return String(localized: "\(components.hour!) hours ago")
        } else if components.hour! >= 1 {
            if numericDates {
                return String(localized: "1 hour ago")
            } else {
                return String(localized: "An hour ago")
            }
        } else if components.minute! >= 2 {
            return String(localized: "\(components.minute!) minutes ago")
        } else if components.minute! >= 1 {
            if numericDates {
                return String(localized: "1 minute ago")
            } else {
                return String(localized: "A minute ago")
            }
        } else {
            return String(localized: "Just now")
        }
    }
}
