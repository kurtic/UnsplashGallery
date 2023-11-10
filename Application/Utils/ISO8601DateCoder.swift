//
//  ISO8601DateCoder.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 10.11.2023.
//

import Foundation

final class ISO8601DateCoder: DateCoder {
    override class var formatter: DateFormatter? { .iso8601 }
}
