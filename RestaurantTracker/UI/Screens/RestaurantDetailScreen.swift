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
        ScrollView {
            VStack {
                // TODO: Implement click and save
                ImageContainerView(
                    imageData: restaurant.photoData,
                    width: .infinity,
                    height: 400
                )

                NameAndMapView(restaurant: restaurant)
                    .padding()

                ReviewsCardView(restaurant: restaurant)
                    .padding()

                // Card for note

                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle(isNew ? "Add Restaurant" : "Restaurant Detail")
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

            // TODO: Add share functionality
        }
    }
}

#Preview {
    NavigationStack {
        RestaurantDetailScreen(restaurant: SampleData.shared.restaurantSample)
    }
}

#Preview("New") {
    NavigationStack {
        RestaurantDetailScreen(
            restaurant: SampleData.shared.restaurantSample,
            isNew: true
        )
    }
}
