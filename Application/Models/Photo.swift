//
//  Photo.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 08.11.2023.
//

import Foundation

struct Photo {
    let id: String
    let createdAt: Date
    let imageUrl: String?
    let authorName: String?
    let authorImageLinkUrl: String?
    let likes: Int
    let isFavourite: Bool = false
    
    var likesAmountText: String {
        "\(likes.formatted()) likes"
    }
    
    var publishedDateStringRepresentable: String {
        "Published on " + DateFormatter.uiDateFormat.string(from: createdAt)
    }
    
    struct Response: Decodable {
        let id: String
        let createdAt: ISO8601DateCoder
        let imageUrl: ImageUrl?
        let user: User?
        let likes: Int
        
        private enum CodingKeys: String, CodingKey {
            case id, user, likes
            case createdAt = "created_at"
            case imageUrl = "urls"
        }
        
        struct ImageUrl: Decodable {
            let regular: String
        }
    }
    
    init(from response: Response) {
        id = response.id
        createdAt = response.createdAt.value
        imageUrl = response.imageUrl?.regular
        authorName = response.user?.name
        authorImageLinkUrl = response.user?.profileImg.small
        likes = response.likes
    }
}
