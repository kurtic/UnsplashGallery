//
//  Photo.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 08.11.2023.
//

import Foundation

struct Photo {
    let id: String
    let promotedAt: String?
    let imageUrl: String?
    let user: User?
    
    struct Response: Decodable {
        let id: String
        let promotedAt: String?
        let imageUrl: ImageUrl?
        let user: User.Response?
        
        private enum CodingKeys: String, CodingKey {
            case id, user
            case promotedAt = "promoted_at"
            case imageUrl = "urls"
        }
        
        struct ImageUrl: Decodable {
            let regular: String
        }
    }
    
    init(from response: Response) {
        id = response.id
        promotedAt = response.promotedAt
        imageUrl = response.imageUrl?.regular
        user = User(from: response.user!)
    }
}
