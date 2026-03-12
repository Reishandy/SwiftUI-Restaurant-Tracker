//
//  Enums.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import Foundation

enum Price: String, Codable, CaseIterable, Identifiable {
    case cheap
    case mid
    case expensive

    var id: Self { self }
}

enum Taste: String, Codable, CaseIterable, Identifiable {
    case trash
    case ok
    case heavenly

    var id: Self { self }
}

enum SortOption: String, CaseIterable {
    case newest = "Newest First"
    case oldest = "Oldest First"
    case nameAtoZ = "Name (A-Z)"
    case nameZtoA = "Name (Z-A)"
    case ratingHigh = "Rating (High)"
    case ratingLow = "Rating (Low)"

    var descriptors: [SortDescriptor<Restaurant>] {
        switch self {
        case .newest:
            return [SortDescriptor(\Restaurant.timestamp, order: .reverse)]
        case .oldest:
            return [SortDescriptor(\Restaurant.timestamp, order: .forward)]
        case .nameAtoZ:
            return [SortDescriptor(\Restaurant.name, order: .forward)]
        case .nameZtoA:
            return [SortDescriptor(\Restaurant.name, order: .reverse)]
        case .ratingHigh:
            return [SortDescriptor(\Restaurant.rating, order: .reverse)]
        case .ratingLow:
            return [SortDescriptor(\Restaurant.rating, order: .forward)]
        }
    }
}
