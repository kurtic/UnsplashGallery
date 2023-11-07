//
//  BaseFactory.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import UIKit

class BaseFactory {
    func makeController<T: Makeable>(_ coordinator: Coordinator, _ builder: T.Builder) -> T
        where T.Value == T, T: UIViewController {
        let controller: T = T.make(builder)
        return controller
    }
    
    func makeController<T: UIViewController & Makeable & UseCasesConsumer>(_ coordinator: Coordinator, _ builder: T.Builder) -> T where T.Value == T {
        guard let useCases = coordinator.useCases as? T.UseCases else {
            fatalError("T.UseCases should be subset of Coordinator.UseCasesProvider")
        }
        let controller: T = T.make {
            //$0.useCases = useCases
            builder(&$0)
        }
        return controller
    }
}
