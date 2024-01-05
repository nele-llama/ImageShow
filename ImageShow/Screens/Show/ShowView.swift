//
//  ShowView.swift
//  ImageShow
//
//  Created by Nenad Biocanin on 4.1.24..
//

import SwiftUI
import Asim

struct ShowView: View {
    @StateObject private var viewModel = ShowViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let remoteImages = viewModel.remoteImages {
                    contentView(remoteImages: remoteImages)
                } else {
                    loadingView
                }
            }
            .task { try? await viewModel.loadData() }
            .navigationTitle("Asim Showcase")
            .toolbar { invalidateCacheButton }
        }
    }
}

private extension ShowView {
    func contentView(remoteImages: [RemoteImage]) -> some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(remoteImages) { remoteImage in
                    ZStack(alignment: .topTrailing) {
                        imageView(for: remoteImage.imageUrl)
                        idView(id: remoteImage.id)
                    }
                }
            }
        }
    }
    
    func imageView(for imageUrl: String) -> some View {
        AsyncImageView(urlString: imageUrl) {
            Text("Downloading...")
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 32)
        .frame(height: 300)
        .clipShape(Rectangle())
        .cornerRadius(12)
    }
    
    func idView(id: Int) -> some View {
        Text("ID: \(id)")
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .padding(8)
    }
    
    var loadingView: some View {
        ProgressView()
            .frame(width: 100, height: 100)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
    }
    
    var invalidateCacheButton: ToolbarItem<(), Button<Text>> {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Invalidate cache") {
                viewModel.invalidateCache()
            }
        }
    }
}

#Preview {
    ShowView()
}
