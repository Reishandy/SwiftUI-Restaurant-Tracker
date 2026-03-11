//
//  RestaurantDetail.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftData
import SwiftUI

struct RestaurantDetailScreen: View {
    @Bindable var restaurant: Restaurant
    let isNew: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    init(restaurant: Restaurant, isNew: Bool = false) {
        self.restaurant = restaurant
        self.isNew = isNew
    }

    var body: some View {
        Form {
            TextField("Restaurant name", text: $restaurant.name)
        }
        .navigationTitle("Restaurant")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(restaurant)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RestaurantDetailScreen(restaurant: SampleData.shared.restaurantSample)
    }
}

#Preview {
    NavigationStack {
        RestaurantDetailScreen(restaurant: SampleData.shared.restaurantSample, isNew: true)
    }
}
