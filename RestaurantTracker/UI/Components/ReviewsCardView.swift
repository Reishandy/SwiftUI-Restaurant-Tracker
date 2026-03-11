//
//  ReviewsCardView.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftUI

struct ReviewsCardView: View {
    @Bindable var restaurant: Restaurant

    var body: some View {
        VStack {
            CardSubHeadingView(text: "Rating")

            RatingView(
                rating: restaurant.rating,
                size: .largeTitle,
                onStarClick: { rating in
                    restaurant.rating = rating
                }
            )
            .padding(.vertical)

            CardSubHeadingView(text: "Price")

            Picker("Price Rating", selection: $restaurant.Price) {
                ForEach(Price.allCases) { rating in
                    Text(rating.rawValue.capitalized).tag(rating)
                }
            }
            .pickerStyle(.segmented)
            .controlSize(.large)
            .padding()

            CardSubHeadingView(text: "Taste")
            
            Picker("Taste Rating", selection: $restaurant.Taste) {
                ForEach(Taste.allCases) { rating in
                    Text(rating.rawValue.capitalized).tag(rating)
                }
            }
            .pickerStyle(.segmented)
            .controlSize(.large)
            .padding()

        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .glassEffect(in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ReviewsCardView(restaurant: SampleData.shared.restaurantSample)
}
