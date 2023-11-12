//
//  FavouritePresenter.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Foundation
import Combine

protocol FavouritePresenterDelegate: Coordinator {
    func openPhotoDetails(for photo: Photo)
}

final class FavouritePresenter {
    
    // MARK: - Private Properties
    private(set) var photos: [Photo] = []
    private let useCases: UseCases
    private var cancellable = Set<AnyCancellable>()
    private weak var favouriteViewDelegate: FavouriteViewDelegate?
    private weak var delegate: FavouritePresenterDelegate?
    
    // MARK: - Life Cycle
    init(useCases: UseCases, delegate: FavouritePresenterDelegate) {
        self.useCases = useCases
        self.delegate = delegate
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
    
    func openPhotoDetails(for photo: Photo) {
        delegate?.openPhotoDetails(for: photo)
    }
}
