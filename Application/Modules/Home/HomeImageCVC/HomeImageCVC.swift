//
//  HomeImageCVC.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 08.11.2023.
//

import UIKit
import Nuke

final class HomeImageCVC: UICollectionViewCell {
    
    private enum C {
        static let cornerRadius: CGFloat = 10
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Configure
    func configure(imageLink: String?) {
        guard let imageLink = imageLink,
              let imageURL = URL(string: imageLink) else { return }
        layer.cornerRadius = C.cornerRadius
        Nuke.loadImage(with: imageURL,options: ImageLoadingOptions(placeholder: R.image.icPlaceholder()), into: imageView)
    }
}
