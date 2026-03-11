//
//  RestaurantCardView.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftUI

struct RestaurantCardView: View {
    let restaurant: Restaurant

    var body: some View {
        ZStack {
            HStack {
                ImageContainerView(
                    imageData: restaurant.photoData,
                    width: 100,
                    height: 100
                )

                VStack {
                    HStack {
                        // Chack if the name is empty, if so display a No Name label instead
                        // This is to prevent empty list name, and so that I don't need to-
                        // implement a required field and validation
                        // I'm just going to copy Apple's Notes style of things
                        if restaurant.name.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty {
                            Text("\"Unnamed Restaurant\"")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                        } else {
                            Text(restaurant.name)
                                .font(.headline)
                        }

                        Spacer()
                    }
                    .padding(.bottom, 8)

                    HStack {
                        RatingView(rating: restaurant.rating)

                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.leading, 8)
            }
            .padding(10)
            .glassEffect(in: RoundedRectangle(cornerRadius: 12))

            NavigationLink(
                destination: RestaurantDetailScreen(
                    restaurant: restaurant
                )
            ) {
                EmptyView()
            }
            .opacity(0)
        }
        .frame(height: 120)
        .padding(8)
    }
}

#Preview {
    RestaurantCardView(restaurant: SampleData.shared.restaurantSample)
        .frame(maxWidth: .infinity, maxHeight: 150)
}
