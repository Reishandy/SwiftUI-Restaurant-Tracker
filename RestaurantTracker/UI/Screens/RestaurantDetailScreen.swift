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
                ImageContainerView(
                    imageData: restaurant.photoData,
                    width: .infinity,
                    height: 400
                )

                // TODO: Extract this
                VStack(alignment: .leading, spacing: 18) {
                    TextField(
                        "Restaurant name",
                        text: $restaurant.name,
                        axis: .vertical
                    )
                    .lineLimit(1...3)
                    .font(.title)
                    .bold()
                    // This is to prevent multi lines on name, so only singe line
                    .onChange(of: restaurant.name) { oldValue, newValue in
                        if newValue.contains("\n") {
                            restaurant.name = newValue.replacingOccurrences(
                                of: "\n",
                                with: ""
                            )
                        }
                    }

                    HStack {
                        // Display the open link button if
                        // it is not empty and is a valid url
                        if !restaurant.mapLink.isEmpty,
                            isValidWebURL(restaurant.mapLink),
                            let mapURL = URL(string: restaurant.mapLink)
                        {
                            Link(destination: mapURL) {
                                Image(systemName: "arrow.up.forward.app")
                                    .font(.title)
                            }
                        }

                        TextField(
                            "Restaurant Map Link",
                            text: $restaurant.mapLink
                        )
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    }
                }
                .padding()

                // Card with reviews

                // Card for note

                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
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
