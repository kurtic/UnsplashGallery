//
//  MainCoordinator.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import UIKit

enum TabBarType: Int, CaseIterable {
    case home, favourite
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: "Home", image: R.image.icHome(), selectedImage: R.image.icHomeSelected())
        case .favourite:
            return UITabBarItem(title: "Favourite", image: R.image.icHeart(), selectedImage: R.image.icHeartSelected())
        }
    }
}

final class MainCoordinator: Coordinator {
    // MARK: - Public Properties
    var useCases: UseCasesProvider
    
    // MARK: - Private Properties
    private var window: UIWindow?
    private weak var presenter: BaseTabBarVC!
    private var childCoordinators: [Coordinator] = []
    
    // MARK: - Life Cycle
    init(useCases: UseCasesProvider, window: UIWindow) {
        self.window = window
        self.useCases = useCases
        setup()
    }
    
    func start(animated: Bool = true) {
        setup()
    }
    
    func stop(animated: Bool = true) {}
    
    private func setup() {
        let bar = BaseTabBarVC()
        presenter = bar
        window?.rootViewController = bar
        configure()
        window?.makeKeyAndVisible()
    }
    
    private func configure() {
        // Home
        let homeNavigation = UINavigationController()
        homeNavigation.tabBarItem = TabBarType.home.tabBarItem
        presenter.addChild(homeNavigation)
        let homeCoordinator = HomeCoordinator(navContoller: homeNavigation, useCases: useCases)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
        
        // Favourite
        let favouriteNavigation = UINavigationController()
        favouriteNavigation.tabBarItem = TabBarType.favourite.tabBarItem
        presenter.addChild(favouriteNavigation)
        let favouriteCoordinator = FavouriteCoordinator(navContoller: favouriteNavigation, useCases: useCases)
        childCoordinators.append(favouriteCoordinator)
        favouriteCoordinator.start()
    }
}
