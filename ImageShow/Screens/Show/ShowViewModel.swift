//
//  ShowViewModel.swift
//  ImageShow
//
//  Created by Nenad Biocanin on 4.1.24..
//

import Foundation
import Asim

final class ShowViewModel: ObservableObject {
    @Published var remoteImages: [RemoteImage]?
    
    init() {
        ImageInvalidator.shared.setInvalidationPeriod(.afterHours(4))
    }
    
    @MainActor
    func loadData() async throws {
        remoteImages = try await NetworkService.loadImages()
    }
    
    func invalidateCache() {
        ImageInvalidator.shared.invalidate()
    }
}
