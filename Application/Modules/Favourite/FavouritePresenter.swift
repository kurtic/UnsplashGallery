//
//  FavouritePresenter.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Foundation
import Combine

protocol FavouritePresenterDelegate: Coordinator {
    // WIP
}

final class FavouritePresenter {
    
    // MARK: - Private Properties
    private(set) var photos: [Photo] = []
    private let useCases: UseCases
    private var cancellable = Set<AnyCancellable>()
    private weak var favouriteViewDelegate: FavouriteViewDelegate?
    
    // MARK: - Life Cycle
    init(useCases: UseCases) {
        self.useCases = useCases
    }
    
    func setFavouriteViewDelegate(delegate: FavouriteViewDelegate) {
        favouriteViewDelegate = delegate
    }
    
    func getAllFavouritePhotos() {
        useCases.photos.getFavouritePhotos()
            .sink { _ in } receiveValue: { [weak self] photos in
                self?.photos = photos
                self?.favouriteViewDelegate?.updateCollectionView()
            }
            .store(in: &cancellable)

    }
}
