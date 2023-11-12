//
//  PhotosService.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Combine
import Alamofire
import CoreData

protocol PhotosUseCase {
    func fetchPhotos(query: String) -> AnyPublisher<[Photo], Error>
    func addPhotoToMyFavourite(photo: Photo) -> AnyPublisher<Void, Error>
    func deletePhotoFromMyFavourite(photoId: String) -> AnyPublisher<Void, Error>
    func getFavouritePhotos() -> AnyPublisher<[Photo], Error>
    func checkIfPhotoIsFavorite(photoId: String) -> AnyPublisher<Bool, Error>
}

final class PhotosService: PhotosUseCase {
    
    private enum C {
        static let token = "VnEwZ1Td74Pwyk-N8a2yH8AuJAppUex8HxYYTQTpJdA"
    }
    
    private lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    func fetchPhotos(query: String) -> AnyPublisher<[Photo], Error> {
        if query.isEmpty {
            fetchRandomPhotos()
        } else {
            searchPhotos(query: query)
        }
    }
    
    private func searchPhotos(query: String) -> AnyPublisher<[Photo], Error> {
        Future<[Photo], Error> { promise in
            AF.request("https://api.unsplash.com/search/photos/?client_id=\(C.token)",
                       method: .get,
                       parameters: query.isEmpty ? nil : ["query" : query],
                       encoding: URLEncoding.default)
            .responseDecodable(of: PhotosData.self) { responseData in
                switch responseData.result {
                case .success(let photosResponse):
                    let photos = photosResponse.results.map { Photo(from: $0) }
                    promise(.success(photos))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func fetchRandomPhotos() -> AnyPublisher<[Photo], Error> {
        Future<[Photo], Error> { promise in
            AF.request("https://api.unsplash.com/photos/random?client_id=\(C.token)&count=30",
                       method: .get,
                       encoding: URLEncoding.default)
            .responseDecodable(of: [Photo.Response].self) { responseData in
                switch responseData.result {
                case .success(let photosResponse):
                    let photos = photosResponse.map { Photo(from: $0) }
                    promise(.success(photos))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addPhotoToMyFavourite(photo: Photo) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
            let photoEntity = PhotoEntity(context: context)
            photoEntity.setValues(from: photo)
            do {
                try context.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deletePhotoFromMyFavourite(photoId: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
            let fetchRequest = PhotoEntity.fetchRequest()
            fetchRequest.predicate = PhotoEntity.findByIdPredicate(photoId)
            do {
                if let storedPhoto = try context.fetch(fetchRequest).first {
                    context.delete(storedPhoto)
                    try context.save()
                }
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getFavouritePhotos() -> AnyPublisher<[Photo], Error> {
        Future<[Photo], Error> { [weak self] promise in
            guard let self = self else { return }
            let fetchRequest = PhotoEntity.fetchRequest()
            do {
                let storedPhotos = try context.fetch(fetchRequest)
                promise(.success(storedPhotos.map { Photo(from: $0)}))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func checkIfPhotoIsFavorite(photoId: String) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { [weak self] promise in
            guard let self = self else { return }
            let fetchRequest = PhotoEntity.fetchRequest()
            fetchRequest.predicate = PhotoEntity.findByIdPredicate(photoId)
            do {
                let storedPhotos = try context.fetch(fetchRequest)
                promise(.success(!storedPhotos.isEmpty))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
