//
//  HomeVC.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import UIKit
import CHTCollectionViewWaterfallLayout

extension HomeVC: Makeable {
    static func make() -> HomeVC { R.storyboard.home.homeVC()! }
}

protocol HomeVCDelegate: AnyObject {
    func updatePhotos()
}

final class HomeVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: - Private properties
    private var presenter: HomePresenter?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setViewDelegate(delegate: self)
        presenter?.fetchPhotos()
        setupCollectionView()
        navigationController?.isNavigationBarHidden = true
        searchBar.searchTextField.
    }
    
    func setPresenter(presenter: HomePresenter) {
        self.presenter = presenter
    }
    
    private func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        layout.minimumInteritemSpacing = 7
        layout.minimumColumnSpacing = 7
        collectionView.collectionViewLayout = layout
        collectionView.registerNib(for: HomeImageCVC.self)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeImageCVC.self),
                                                            for: indexPath) as? HomeImageCVC else { return UICollectionViewCell() }
        cell.configure(imageLink: presenter?.photos[indexPath.row].imageUrl)
        return cell
    }
}

// MARK: - CHTCollectionViewDelegateWaterfallLayout
extension HomeVC: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width/2, height: CGFloat.random(in: 300...500))
    }
}

extension HomeVC: HomeVCDelegate {
    func updatePhotos() {
        collectionView.reloadData()
    }
}
