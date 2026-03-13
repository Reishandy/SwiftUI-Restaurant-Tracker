//
//  RatingView.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftUI

struct RatingView: View {
    let rating: Int
    var size: Font? = Font.body
    var onStarClick: ((Int) -> Void)? = nil

    var body: some View {
        HStack {
            ForEach(0..<5, id: \.description) { number in
                Image(systemName: "star.fill")
                    .onTapGesture {
                        onStarClick?(number + 1)
                    }
                    .font(size)
                    .foregroundStyle(
                        number >= rating ? .yellow.opacity(1 / 4) : .yellow
                    )
                    .shadow(
                        color: Color.yellow.opacity(0.8),
                        radius: 10,
                        x: 0,
                        y: 0
                    )
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: rating)
    }
}

#Preview {
    RatingView(
        rating: 3,
        size: .largeTitle,
        onStarClick: { amount in }
    )
}
