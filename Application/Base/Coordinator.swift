//
//  Coordinator.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var useCases: UseCasesProvider { get }
    
    func start(animated: Bool)
    func stop(animated: Bool)
}
