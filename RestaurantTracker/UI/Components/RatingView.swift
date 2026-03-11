//
//  RatingView.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftUI

struct RatingView: View {
    let rating: Int
    var onStarClick: ((Int) -> Void)? = nil
    // onStarClick will return the tapped star's value
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.description) { number in
                Image(systemName: number >= rating ? "star" : "star.fill")
                    .onTapGesture {
                        onStarClick?(number)
                    }
            }
        }
    }
}

#Preview {
    RatingView(
        rating: 3,
        onStarClick: { amount in }
    )
}
