//
//  HomeFactory.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Foundation

final class HomeFactory: BaseFactory {
    
    static var main = HomeFactory()
    private override init() {}
    
    func makeHomeVC<T: Coordinator & HomePresenterDelegate>(delegate: T) -> HomeVC {
        makeController(delegate) {
            $0.setPresenter(presenter: HomePresenter(useCases: delegate.useCases, delegate: delegate))
        }
    }
}
