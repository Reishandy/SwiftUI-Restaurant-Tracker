//
//  CardSubHeading.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftUI

struct CardSubHeadingView: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
    }
}

#Preview {
    CardSubHeadingView(text: "Example")
}
