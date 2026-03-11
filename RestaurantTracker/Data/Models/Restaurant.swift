//
//  Restaurant.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import Foundation
import SwiftData

enum Price: String, Codable, CaseIterable {
    case cheap
    case expensive
}

enum Taste: String, Codable, CaseIterable {
    case trash
    case meh
    case heavenly
}

@Model
class Restaurant {
    var id: UUID
    var timestamp: Date

    var name: String
    var mapLink: String
    var notes: String
    var rating: Int
    var Price: Price
    var Taste: Taste

    @Attribute(.externalStorage) var photoData: Data?

    init(
        id: UUID = UUID(),
        timestamp: Date = Date(),
        name: String,
        mapLink: String,
        notes: String,
        rating: Int,
        price: Price,
        taste: Taste,
        photoData: Data? = nil
    ) {
        self.id = id
        self.timestamp = timestamp
        self.name = name
        self.mapLink = mapLink
        self.notes = notes
        self.rating = rating
        self.Price = price
        self.Taste = taste
        self.photoData = photoData
    }
    
    static let sampleData = [
        Restaurant(
            name: "Resto 1",
            mapLink: "https://reishandy.id/",
            notes: "",
            rating: 4,
            price: .cheap,
            taste: .meh,
        ),
        Restaurant(
            name: "Resto 2",
            mapLink: "https://reishandy.id/",
            notes: "Do not go here ever again!",
            rating: 1,
            price: .expensive,
            taste: .trash,
        ),
        Restaurant(
            name: "Resto 3",
            mapLink: "https://reishandy.id/",
            notes: "The goat",
            rating: 5,
            price: .cheap,
            taste: .heavenly,
        ),
        Restaurant(
            name: "Resto 4",
            mapLink: "https://reishandy.id/",
            notes: "Avoid the fried fish, kinda bad",
            rating: 3,
            price: .expensive,
            taste: .meh,
        )
    ]
}
