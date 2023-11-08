//
//  HomeVC.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import UIKit

extension HomeVC: Makeable {
    static func make() -> HomeVC { R.storyboard.home.homeVC()! }
}

protocol HomeVCDelegate: AnyObject {
    func updatePhotos()
}

final class HomeVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private properties
    private var presenter: HomePresenter?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setViewDelegate(delegate: self)
        presenter?.fetchPhotos()
    }
    
    func setPresenter(presenter: HomePresenter) {
        self.presenter = presenter
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}

extension HomeVC: HomeVCDelegate {
    func updatePhotos() {
        collectionView.reloadData()
    }
}
