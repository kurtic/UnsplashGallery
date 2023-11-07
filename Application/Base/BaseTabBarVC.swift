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
        //configTabBarUI()
        self.setupTabBarUI()
        self.addCustomTabBarView()
    }
    
    // MARK: - GUI
//    private func configTabBarUI() {
//        tabBar.backgroundImage = UIImage()
//        tabBar.backgroundColor = .white
//        tabBar.tintColor = .black
//        view.layer.shadowColor = UIColor.black.withAlphaComponent(0).cgColor
//        view.layer.shadowOffset = CGSize(width: -4, height: -6)
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowRadius = 20
//    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupCustomTabBarFrame()
    }
    
    // MARK: Private methods
    
    private func setupCustomTabBarFrame() {
        let height = self.view.safeAreaInsets.bottom + 64
        
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = self.view.frame.size.height - height
        
        self.tabBar.frame = tabFrame
        self.tabBar.setNeedsLayout()
        self.tabBar.layoutIfNeeded()
        customTabBarView.frame = tabBar.frame
    }
    
    private func setupTabBarUI() {
        // Setup your colors and corner radius
        self.tabBar.backgroundColor = .white
        self.tabBar.layer.cornerRadius = 30
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.tintColor = .black
        //self.tabBar.unselectedItemTintColor = UIColor.fillColor3
    }
    
    private func addCustomTabBarView() {
        self.customTabBarView.frame = tabBar.frame
        self.customTabBarView.backgroundColor = .white
        self.customTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.customTabBarView.layer.masksToBounds = false
        self.customTabBarView.layer.shadowColor = R.color.darkGray()?.withAlphaComponent(0.08).cgColor
        self.customTabBarView.layer.shadowOffset = CGSize(width: 0, height: -4)
        self.customTabBarView.layer.shadowOpacity = 1
        //self.customTabBarView.layer.shadowRadius = 20
        
        self.view.addSubview(customTabBarView)
        self.view.bringSubviewToFront(self.tabBar)
    }
}
