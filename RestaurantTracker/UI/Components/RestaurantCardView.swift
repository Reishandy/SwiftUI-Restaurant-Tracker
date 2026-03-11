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
                IconView(imageData: restaurant.photoData)

                VStack {
                    HStack {
                        Text(restaurant.name)
                            .font(.headline)

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
            .glassEffect(in: RoundedRectangle(cornerRadius: 12))  // TODO: Solve the shadow conflict with the list

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
