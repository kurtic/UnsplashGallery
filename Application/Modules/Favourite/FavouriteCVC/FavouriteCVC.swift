//
//  FavouriteCVC.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 10.11.2023.
//

import UIKit
import Nuke

final class FavouriteCVC: UICollectionViewCell {
    private enum C {
        static let photoCornerRadius: CGFloat = 10
        static let authorImageCornerRadius: CGFloat = 10
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var authorImageView: UIImageView!
    @IBOutlet private weak var authorNameLabel: UILabel!
    
    // MARK: - Configure
    func configure(with photo: Photo) {
        photoImageView.layer.cornerRadius = C.photoCornerRadius
        authorImageView.layer.cornerRadius = C.authorImageCornerRadius
        authorNameLabel.text = photo.authorName
        if let photoURL = URL(string: photo.imageUrl ?? ""),
           let authorImageLinkUrl = URL(string:photo.authorImageLinkUrl ?? "") {
            Nuke.loadImage(with: photoURL, into: photoImageView)
            Nuke.loadImage(with: authorImageLinkUrl, into: authorImageView)
        }
    }
}
