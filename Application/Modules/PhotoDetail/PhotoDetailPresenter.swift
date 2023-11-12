//
//  PhotoDetailPresenter.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 09.11.2023.
//

import Foundation
import Combine

protocol PhotoDetailPresenterDelegate: Coordinator {
    func showShareScreen(for photo: Photo)
    func showSuccessAddingToFavouriteAlert()
}

final class PhotoDetailPresenter {
    
    // MARK: - Private Properties
    private weak var delegate: PhotoDetailPresenterDelegate?
    private weak var photoDetailViewDelegate: PhotoDetailViewDelegate?
    private let useCases: UseCases
    private(set) var photo: Photo
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Life Cycle
    init(useCases: UseCases,
         photo: Photo,
         delegate: PhotoDetailPresenterDelegate) {
        self.useCases = useCases
        self.delegate = delegate
        self.photo = photo
    }
    
    func checkIfPhotoIsFavorite() {
        useCases.photos.checkIfPhotoIsFavorite(photoId: photo.id)
            .sink { _ in } receiveValue: { [weak self] isAlreadyFavourite in
                self?.photo.isFavourite = isAlreadyFavourite
                self?.photoDetailViewDelegate?.updateFavouriteButton()
            }
            .store(in: &cancellable)
    }
    
    func setPhotoDetailViewDelegate(with delegate: PhotoDetailViewDelegate) {
        photoDetailViewDelegate = delegate
    }
    
    func backButtonTapped() {
        delegate?.stop(animated: true)
    }
    
    func shareButtonTapped() {
        delegate?.showShareScreen(for: photo)
    }
    
    func favouriteButtonTapped() {
        if !photo.isFavourite {
            photo.isFavourite = true
            useCases.photos.addPhotoToMyFavourite(photo: photo)
                .sink { _ in } receiveValue: { [weak self] _ in
                    self?.photoDetailViewDelegate?.updateFavouriteButton()
                    self?.delegate?.showSuccessAddingToFavouriteAlert()
                }
                .store(in: &cancellable)
        } else {
            useCases.photos.deletePhotoFromMyFavourite(photoId: photo.id)
                .sink { _ in } receiveValue: { [weak self] _ in
                    guard let self = self else { return }
                    photo.isFavourite = false
                    photoDetailViewDelegate?.updateFavouriteButton()
                }
                .store(in: &cancellable)
        }
    }
}
