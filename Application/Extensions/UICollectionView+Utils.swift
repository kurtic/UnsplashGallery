//
//  UICollectionView+Utils.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 08.11.2023.
//

import UIKit

extension UICollectionView {
    func registerNib<T>(for cellClass: T.Type) where T: UICollectionViewCell {
        let identifier = String(describing: cellClass)
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
}
