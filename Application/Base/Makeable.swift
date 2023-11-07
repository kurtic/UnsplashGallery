//
//  Makeable.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Foundation

import Foundation

protocol Makeable {
    associatedtype Value = Self
    typealias Builder = (inout Value) -> Void
    static func make() -> Value
}

extension Makeable {
    static func make(_ builder: Builder) -> Value {
        var product = make()
        builder(&product)
        return product
    }
}
