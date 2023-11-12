//
//  Platform.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Foundation

import Foundation

final class Platform: UseCasesProvider {
    var photos: PhotosUseCase
    
    init() {
        photos = PhotosService()
    }
}
