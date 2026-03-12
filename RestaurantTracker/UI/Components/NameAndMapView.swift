//
//  NameAndMapView.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftUI

struct NameAndMapView: View {
    @Bindable var restaurant: Restaurant
    
    var body: some View {
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
                    .transition(.move(edge: .leading).combined(with: .opacity))
                }

                TextField(
                    "Restaurant Map Link",
                    text: $restaurant.mapLink
                )
                .font(.title3)
                .foregroundStyle(.secondary)
            }
            .animation(.easeInOut, value: restaurant.mapLink)
        }
    }
}

#Preview {
    NameAndMapView(restaurant: SampleData.shared.restaurantSample)
}
