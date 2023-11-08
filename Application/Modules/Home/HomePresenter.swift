//
//  HomePresenter.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Combine

protocol HomePresenterDelegate: Coordinator {
    // WIP
}

final class HomePresenter {
    
    // MARK: - Private Properties
    private let useCases: UseCases
    private(set) var photos: [Photo] = []
    private var cancellable = Set<AnyCancellable>()
    private weak var delegate: HomePresenterDelegate?
    private weak var homeViewDelegate: HomeVCDelegate?
    private let query = ""
    
    
    // MARK: - Life Cycle
    init(useCases: UseCases,
         delegate: HomePresenterDelegate) {
        self.useCases = useCases
        self.delegate = delegate
    }
    
    func setViewDelegate(delegate: HomeVCDelegate) {
        homeViewDelegate = delegate
    }
    
    func fetchPhotos() {
        useCases.photos.fetchPhotos(query: query)
            .sink { _ in } receiveValue: { [weak self] photos in
                self?.photos = photos
                self?.homeViewDelegate?.updatePhotos()
                print(photos)
            }
            .store(in: &cancellable)
    }
}
