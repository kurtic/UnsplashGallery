//
//  User.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 08.11.2023.
//

import Foundation

struct User: Decodable {
    let id: String
    let username: String?
    let name: String?
    let profileImg: ProfileImg
    
    private enum CodingKeys: String, CodingKey {
        case id, username, name
        case profileImg = "profile_image"
    }
    
    struct ProfileImg: Decodable {
        let small: String
    }
}
