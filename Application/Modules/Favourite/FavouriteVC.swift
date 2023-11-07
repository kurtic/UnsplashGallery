//
//  FavouriteVC.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import UIKit

extension FavouriteVC: Makeable {
    static func make() -> FavouriteVC { R.storyboard.favourite.favouriteVC()! }
}

final class FavouriteVC: UIViewController {
    private var presenter: FavouritePresenter?
    
    func setPresenter(presenter: FavouritePresenter) {
        self.presenter = presenter
    }
}
