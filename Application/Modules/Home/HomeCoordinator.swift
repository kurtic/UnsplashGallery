//
//  HomeCoordinator.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import UIKit

final class HomeCoordinator: Coordinator {
    // MARK: - Public Properties
    var useCases: UseCasesProvider
    
    // MARK: - Private Properties
    private weak var presenter: UINavigationController!
    
    // MARK: - Life Cycle
    init(navContoller: UINavigationController, useCases: UseCasesProvider) {
        self.useCases = useCases
        self.presenter = navContoller
    }
    
    func start(animated: Bool = true) {
        let articlesVC = Factory.home.makeHomeVC(delegate: self)
        presenter.pushViewController(articlesVC, animated: animated)
    }
    
    func stop(animated: Bool = true) {
        presenter.popViewController(animated: animated)
    }
}

// MARK: - HomePresenterDelegate
extension HomeCoordinator: HomePresenterDelegate {
    func openPhotoDetails(for photo: Photo) {
        let photoDetailsVC = Factory.home.makePhotoDetailsVC(delegate: self, photo: photo)
        presenter.pushViewController(photoDetailsVC, animated: true)
    }
}

// MARK: - PhotoDetailPresenterDelegate
extension HomeCoordinator: PhotoDetailPresenterDelegate {
    func showSuccessAddingToFavouriteAlert() {
        let alert = Factory.utils.makeAlertController()
        presenter.present(alert, animated: true, completion: nil)
    }
    
    func showShareScreen(for photo: Photo) {
        guard let imageUrl = photo.imageUrl else { return }
        let shareVC = Factory.utils.makeShareVC(imageUrl: imageUrl)
        presenter.present(shareVC, animated: true)
    }
}

