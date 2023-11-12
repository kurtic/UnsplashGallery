//
//  FavouriteFactory.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Foundation

final class FavouriteFactory: BaseFactory {
    
    static var main = FavouriteFactory()
    private override init() {}
    
    func makeFavouriteVC<T: Coordinator & FavouritePresenterDelegate>(delegate: T) -> FavouriteVC {
        makeController(delegate) {
            $0.setPresenter(presenter: FavouritePresenter(useCases: delegate.useCases, delegate: delegate))
        }
    }
}
