//
//  IconView.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import SwiftUI

struct ImageContainerView: View {
    let imageData: Data?
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        if let imageData = imageData {
            if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: width, height: height)
                    .foregroundStyle(Color(UIColor.secondaryLabel))

                Image(systemName: "photo")
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    ImageContainerView(
        imageData: nil,
        width: 300,
        height: 300
    )
}
