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

protocol FavouriteViewDelegate: AnyObject {
    func updateCollectionView()
}

final class FavouriteVC: UIViewController {
    
    private enum C {
        static let spacing: CGFloat = 10
    }
    
    private var presenter: FavouritePresenter?
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        collectionView.registerNib(for: FavouriteCVC.self)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getAllFavouritePhotos()
    }
    
    func setPresenter(presenter: FavouritePresenter) {
        self.presenter = presenter
        self.presenter?.setFavouriteViewDelegate(delegate: self)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FavouriteVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photo = presenter?.photos[indexPath.item],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavouriteCVC.self),
                                                            for: indexPath) as? FavouriteCVC else { return UICollectionViewCell() }
        cell.configure(with: photo)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavouriteVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width - C.spacing) / 2
        let itemSize = CGSize(width: itemWidth, height: itemWidth * 1.3)
        return itemSize
    }
}

// MARK: - FavouriteViewDelegate
extension FavouriteVC: FavouriteViewDelegate {
    func updateCollectionView() {
        collectionView.reloadData()
    }
}
