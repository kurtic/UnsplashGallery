//
//  PhotoDetailPresenter.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 09.11.2023.
//

import Foundation

protocol PhotoDetailPresenterDelegate: Coordinator {
    // WIP
}

final class PhotoDetailPresenter {
    
    // MARK: - Private Properties
    private weak var delegate: PhotoDetailPresenterDelegate?
    private weak var photoDetailViewDelegate: PhotoDetailViewDelegate?
    private let useCases: UseCases
    private(set) var photo: Photo
    
    // MARK: - Life Cycle
    init(useCases: UseCases,
         photo: Photo,
         delegate: PhotoDetailPresenterDelegate) {
        self.useCases = useCases
        self.delegate = delegate
        self.photo = photo
    }
    
    func setPhotoDetailViewDelegate(with delegate: PhotoDetailViewDelegate) {
        photoDetailViewDelegate = delegate
    }
    
    func backButtonTapped() {
        delegate?.stop(animated: true)
    }
}
