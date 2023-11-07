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

final class HomeVC: UIViewController {
    
    private var presenter: HomePresenter?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // WIP
    }
    
    func setPresenter(presenter: HomePresenter) {
        self.presenter = presenter
    }
}
