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
        let articlesVC = Factory.homeFactory.makeHomeVC(delegate: self)
        presenter.pushViewController(articlesVC, animated: animated)
    }
    
    func stop(animated: Bool = true) {
        presenter.popViewController(animated: animated)
    }
}

// MARK: - HomePresenterDelegate
extension HomeCoordinator: HomePresenterDelegate {
    // WIP
}
