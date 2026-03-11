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

    // One thing about the frame difference
    // In real photo I used maxW and maxH to let the container follow the photo-
    // and then the max is set by the parent
    // While the no image I used normal w h to make it the standard for the parent
    var body: some View {
        if let imageData = imageData {
            if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: width, maxHeight: height)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: width, height: height)
                    .foregroundStyle(Color(UIColor.secondaryLabel))

                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
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
