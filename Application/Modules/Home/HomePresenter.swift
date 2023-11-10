//
//  HomePresenter.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Combine
import Foundation

protocol HomePresenterDelegate: Coordinator {
    func openPhotoDetails(for photo: Photo)
}

final class HomePresenter {
    
    // MARK: - Private Properties
    private let useCases: UseCases
    private(set) var photos: [Photo] = []
    private var cancellable = Set<AnyCancellable>()
    private weak var delegate: HomePresenterDelegate?
    private weak var homeViewDelegate: HomeVCDelegate?
    private let query = CurrentValueSubject<String, Never>("")
    
    
    // MARK: - Life Cycle
    init(useCases: UseCases,
         delegate: HomePresenterDelegate) {
        self.useCases = useCases
        self.delegate = delegate
        
        query
            .dropFirst()
            .debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .sink { _ in } receiveValue: { [weak self] query in
                self?.fetchPhotos(for: query)
            }
            .store(in: &cancellable)
    }
    
    func setViewDelegate(delegate: HomeVCDelegate) {
        homeViewDelegate = delegate
    }
    
    func fetchPhotos(for query: String = "") {
        homeViewDelegate?.showOrHideAcivity(shouldHide: false)
        useCases.photos.fetchPhotos(query: query)
            .sink { [weak self] result in
                if case .failure(_) = result {
                    self?.homeViewDelegate?.showOrHideAcivity(shouldHide: true)
                }
            } receiveValue: { [weak self] photos in
                self?.photos = photos
                self?.homeViewDelegate?.updatePhotos()
                self?.homeViewDelegate?.showOrHideAcivity(shouldHide: true)
            }
            .store(in: &cancellable)
    }
    
    func setQuery(with query: String) {
        self.query.value = query
    }
    
    func openPhotoDetails(for photo: Photo) {
        delegate?.openPhotoDetails(for: photo)
    }
}
