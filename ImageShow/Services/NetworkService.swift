//
//  NetworkService.swift
//  ImageShow
//
//  Created by Nenad Biocanin on 4.1.24..
//

import Foundation

struct NetworkService {
    private static var sourceURL: URL? {
        URL(string: "https://zipoapps-storage-test.nyc3.digitaloceanspaces.com/image_list.json")
    }
    
    static func loadImages() async throws -> [RemoteImage]? {
        guard let sourceURL else { return nil }
        let data = try await URLSession.shared.data(from: sourceURL).0
        return try JSONDecoder().decode([RemoteImage].self, from: data)
    }
}
