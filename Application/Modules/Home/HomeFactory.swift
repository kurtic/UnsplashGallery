//
//  HomeFactory.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import UIKit

final class HomeFactory: BaseFactory {
    
    static var main = HomeFactory()
    private override init() {}
    
    func makeHomeVC<T: Coordinator & HomePresenterDelegate>(delegate: T) -> HomeVC {
        makeController(delegate) {
            $0.setPresenter(presenter: HomePresenter(useCases: delegate.useCases, delegate: delegate))
        }
    }
    
    func makePhotoDetailsVC<T: Coordinator & PhotoDetailPresenterDelegate>(delegate: T, photo: Photo) -> PhotoDetailVC {
        makeController(delegate) {
            $0.setPresenter(with: PhotoDetailPresenter(useCases: delegate.useCases, photo: photo, delegate: delegate))
        }
    }
}
