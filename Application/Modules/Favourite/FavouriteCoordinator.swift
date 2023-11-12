//
//  FavouriteCoordinator.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import UIKit

final class FavouriteCoordinator: Coordinator {
    // MARK: - Public Properties
    var useCases: UseCasesProvider
    
    // MARK: - Private Properties
    private weak var navController: UINavigationController!
    
    // MARK: - Life Cycle
    init(navContoller: UINavigationController, useCases: UseCasesProvider) {
        self.useCases = useCases
        self.navController = navContoller
    }
    
    func start(animated: Bool = true) {
        let articlesVC = Factory.favourite.makeFavouriteVC(delegate: self)
        navController.pushViewController(articlesVC, animated: animated)
    }
    
    func stop(animated: Bool = true) {
        navController.popViewController(animated: animated)
    }
}

// MARK: - HomePresenterDelegate
extension FavouriteCoordinator: FavouritePresenterDelegate {
    func openPhotoDetails(for photo: Photo) {
        let photoDetailsVC = Factory.home.makePhotoDetailsVC(delegate: self, photo: photo)
        navController.pushViewController(photoDetailsVC, animated: true)
    }
}

// MARK: - PhotoDetailPresenterDelegate
extension FavouriteCoordinator: PhotoDetailPresenterDelegate {
    func showSuccessAddingToFavouriteAlert() {
        let alert = Factory.utils.makeAlertController()
        navController.present(alert, animated: true, completion: nil)
    }
    
    func showShareScreen(for photo: Photo) {
        guard let imageUrl = photo.imageUrl else { return }
        let shareVC = Factory.utils.makeShareVC(imageUrl: imageUrl)
        navController.present(shareVC, animated: true)
    }
}
