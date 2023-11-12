//
//  PhotoEntity+CoreDataProperties.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 10.11.2023.
//
//

import Foundation
import CoreData

@objc(PhotoEntity)
public class PhotoEntity: NSManagedObject {
    func setValues(from photo: Photo) {
        id = photo.id
        createdAt = photo.createdAt
        imageUrl = photo.imageUrl
        authorName = photo.authorName
        authorImageLinkUrl = photo.authorImageLinkUrl
        likes = Int32(photo.likes)
        isFavourite = photo.isFavourite
    }
}

extension PhotoEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }
    
    @nonobjc public class func findByIdPredicate(_ id: String) -> NSPredicate {
        NSPredicate(format: "%K == %@", argumentArray: [#keyPath(PhotoEntity.id), id])
    }
    
    @nonobjc public class func favouritePredicate() -> NSPredicate {
        NSPredicate(format: "%K == %@", argumentArray: [#keyPath(PhotoEntity.isFavourite), true])
    }

    @NSManaged public var id: String
    @NSManaged public var createdAt: Date?
    @NSManaged public var imageUrl: String?
    @NSManaged public var authorName: String?
    @NSManaged public var authorImageLinkUrl: String?
    @NSManaged public var likes: Int32
    @NSManaged public var isFavourite: Bool
}
