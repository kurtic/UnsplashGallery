//
//  PhotosData.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 08.11.2023.
//

import Foundation

struct PhotosData: Decodable {
    let results: [Photo.Response]
    let total: Int
}
