//
//  RestaurantDetail.swift
//  RestaurantTracker
//
//  Created by Muhammad Akbar Reishandy on 11/03/26.
//

import PhotosUI
import SwiftData
import SwiftUI

struct RestaurantDetailScreen: View {
    @Bindable var restaurant: Restaurant
    let isNew: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var selectedPhoto: PhotosPickerItem?

    init(restaurant: Restaurant, isNew: Bool = false) {
        self.restaurant = restaurant
        self.isNew = isNew
    }

    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    PhotosPicker(
                        selection: $selectedPhoto,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        ImageContainerView(
                            imageData: restaurant.photoData,
                            width: .infinity,
                            height: 400
                        )
                    }
                    .foregroundStyle(.secondary)
                    .onChange(of: selectedPhoto) { oldPhoto, newPhoto in
                        Task {
                            if let data = try? await newPhoto?.loadTransferable(
                                type: Data.self
                            ) {
                                restaurant.photoData = data
                            }
                        }
                    }

                    if restaurant.photoData != nil {
                        Button("Delete Image", systemImage: "trash.circle") {
                            restaurant.photoData = nil
                        }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.glassProminent)
                        .tint(.red)
                        .padding()
                    }
                }

                NameAndMapView(restaurant: restaurant)
                    .padding()

                ReviewsCardView(restaurant: restaurant)
                    .padding()

                NoteCardView(restaurant: restaurant)
                    .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle(isNew ? "Add Restaurant" : "Restaurant Detail")
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
        .scrollDismissesKeyboard(.interactively)
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
