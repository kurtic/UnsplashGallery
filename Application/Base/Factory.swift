//
//  Factory.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Foundation

struct Factory {
    static let home = HomeFactory.main
    static let favourite = FavouriteFactory.main
    static let utils = UtilsFactory.main
}
