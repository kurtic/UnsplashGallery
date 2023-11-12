//
//  UseCasesConsumer.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Foundation

protocol UseCasesConsumer: AnyObject {
    associatedtype UseCases
    
    var useCases: UseCases { get }
}
