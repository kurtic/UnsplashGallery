//
//  UseCasesProvider.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Foundation

protocol UseCasesProvider: UseCases {}

internal protocol HasPhotosUseCase {
    var photos: PhotosUseCase { get }
}

typealias UseCases = HasPhotosUseCase
