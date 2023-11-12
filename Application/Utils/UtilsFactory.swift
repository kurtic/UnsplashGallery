//
//  UtilsFactory.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 12.11.2023.
//

import UIKit

final class UtilsFactory: BaseFactory {
    static var main = UtilsFactory()
    private override init() {}

    func makeShareVC(imageUrl: String) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: [NSURL(string: imageUrl) as Any], applicationActivities: nil)
        activityViewController.activityItemsConfiguration = [UIActivity.ActivityType.message] as? UIActivityItemsConfigurationReading
        activityViewController.isModalInPresentation = true
        return activityViewController
    }
    
    func makeAlertController() -> UIAlertController {
        let alert = UIAlertController(title: "Success!", message: "Photo added to your favourite", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
}
