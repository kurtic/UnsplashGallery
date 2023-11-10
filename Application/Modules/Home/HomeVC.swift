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
    func showOrHideAcivity(shouldHide: Bool)
}

final class HomeVC: BaseVC {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: - Private properties
    private var presenter: HomePresenter?
    private lazy var refreshControl = UIRefreshControl()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setViewDelegate(delegate: self)
        presenter?.fetchPhotos()
        setupCollectionView()
        setupUI()
    }
    
    private func setupUI() {
        navigationController?.isNavigationBarHidden = true
        searchBar.searchTextField.textInputView.bounds = CGRect(x: -5, y: 0, width: 0, height: 0)
        searchBar.delegate = self
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardByTappingOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboardByTappingOutside() {
        searchBar.endEditing(true)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        presenter?.fetchPhotos()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = presenter?.photos[indexPath.row] else { return }
        presenter?.openPhotoDetails(for: photo)
    }
}

// MARK: - CHTCollectionViewDelegateWaterfallLayout
extension HomeVC: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 2, height: CGFloat.random(in: 300...500))
    }
}

// MARK: - HomeVCDelegate
extension HomeVC: HomeVCDelegate {
    func showOrHideAcivity(shouldHide: Bool) {
        if shouldHide {
            stopShowingActivity()
            refreshControl.endRefreshing()
        } else {
            startShowingActivity()
        }
    }
    
    func updatePhotos() {
        collectionView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.setQuery(with: searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        presenter?.setQuery(with: searchBar.text ?? "")
    }
}
