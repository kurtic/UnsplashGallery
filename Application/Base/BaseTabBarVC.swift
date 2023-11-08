//
//  BaseTabBarVC.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import UIKit

final class BaseTabBarVC: UITabBarController {
    
    private var customTabBarView = UIView(frame: .zero)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarUI()
        addCustomTabBarView()
    }
    
    // MARK: - GUI
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCustomTabBarFrame()
    }
    
    // MARK: Private methods
    private func setupCustomTabBarFrame() {
        let height = view.safeAreaInsets.bottom + 64
        
        var tabFrame = tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = view.frame.size.height - height
        
        tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
        tabBar.layoutIfNeeded()
        customTabBarView.frame = tabBar.frame
    }
    
    private func setupTabBarUI() {
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 30
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.tintColor = .black
    }
    
    private func addCustomTabBarView() {
        customTabBarView.frame = tabBar.frame
        customTabBarView.backgroundColor = .white
        customTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        customTabBarView.layer.masksToBounds = false
        customTabBarView.layer.shadowColor = R.color.darkGray()?.withAlphaComponent(0.08).cgColor
        customTabBarView.layer.shadowOffset = CGSize(width: 0, height: -4)
        customTabBarView.layer.shadowOpacity = 1
        
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(tabBar)
    }
}
