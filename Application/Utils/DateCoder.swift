//
//  DateCoder.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 10.11.2023.
//

import Foundation

class DateCoder: Codable {
    class var formatter: DateFormatter? {
        return nil
    }

    let value: Date

    init(date: Date) {
        value = date
    }
    
    required init(from decoder: Decoder) throws {
        let string = try String(from: decoder)
        if let formatter = type(of: self).formatter {
            if let date = formatter.date(from: string) {
                value = date
            } else {
                let context = DecodingError.Context(codingPath: decoder.codingPath,
                                                    debugDescription: """
                                                    Invalid date format, expected \(String(describing: formatter.dateFormat)), actual \(string)
                                                    """)
                throw DecodingError.dataCorrupted(context)
            }
        } else {
            value = try Date(from: decoder)
        }
    }

    func encode(to encoder: Encoder) throws {
        if let formatter = type(of: self).formatter {
            try formatter.string(from: value).encode(to: encoder)
        } else {
            try value.encode(to: encoder)
        }
    }
}
