//
//  PhotoDetailVC.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 09.11.2023.
//

import UIKit
import Nuke

extension PhotoDetailVC: Makeable {
    static func make() -> PhotoDetailVC {
        R.storyboard.photoDetail.photoDetailVC()!
    }
}

protocol PhotoDetailViewDelegate: AnyObject {
    func updateFavouriteButton()
}

final class PhotoDetailVC: UIViewController {
    
    private enum C {
        static let detailPhotoCornerRadius: CGFloat = 10
        static let authorImageCornerRadius: CGFloat = 16
        static let titleText = "Details"
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var detailPhotoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var authorImageView: UIImageView!
    @IBOutlet private weak var likesAmountLabel: UILabel!
    @IBOutlet private weak var publishedDateLabel: UILabel!
    
    // MARK: - Private Properties
    private var presenter: PhotoDetailPresenter?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.checkIfPhotoIsFavorite()
    }
    
    // MARK: - Setup UI
    func setupUI() {
        detailPhotoImageView.layer.cornerRadius = C.detailPhotoCornerRadius
        authorImageView.layer.cornerRadius = C.authorImageCornerRadius
        titleLabel.text = C.titleText
        authorNameLabel.text = presenter?.photo.authorName
        likesAmountLabel.text = presenter?.photo.likesAmountText
        publishedDateLabel.text = presenter?.photo.publishedDateStringRepresentable
        if let imageUrl = URL(string: presenter?.photo.imageUrl ?? ""),
           let authorImageUrl = URL(string: presenter?.photo.authorImageLinkUrl ?? "") {
            Nuke.loadImage(with: imageUrl, into: detailPhotoImageView)
            Nuke.loadImage(with: authorImageUrl, into: authorImageView)
        }
    }
    
    func setPresenter(with presenter: PhotoDetailPresenter) {
        self.presenter = presenter
        self.presenter?.setPhotoDetailViewDelegate(with: self)
    }
    
    // MARK: - IBActions
    @IBAction private func backButtonTapped(_ sender: Any) {
        presenter?.backButtonTapped()
    }
    
    @IBAction private func shareButtonTapped(_ sender: Any) {
        // WIP
    }
    
    @IBAction private func likeButtonTapped(_ sender: Any) {
        presenter?.favouriteButtonTapped()
    }
}

// MARK: - PhotoDetailViewDelegate
extension PhotoDetailVC: PhotoDetailViewDelegate {
    func updateFavouriteButton() {
        let buttonImage = (presenter?.photo.isFavourite ?? false) ? R.image.icFilledHeart()! : R.image.icLike()!
        likeButton.setImage(buttonImage, for: .normal)
    }
}
