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
