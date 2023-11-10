//
//  AppCoordinator.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import UIKit

final class AppCoordinator {
    // MARK: - Properties
    let window = UIWindow(frame: UIScreen.main.bounds)
    private let useCases: UseCasesProvider
    private var childCoordinators: [Coordinator] = []
    
    
    // MARK: - Life Cycle
    init(useCases: UseCasesProvider) {
        self.useCases = useCases
        let coordinator = MainCoordinator(useCases: self.useCases, window: window)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

