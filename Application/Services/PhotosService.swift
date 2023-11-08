//
//  PhotosService.swift
//  UnsplashGallery
//
//  Created by Diachenko Ihor on 07.11.2023.
//

import Combine
import Alamofire

protocol PhotosUseCase {
    func fetchPhotos(query: String) -> AnyPublisher<[Photo], Error>
}

final class PhotosService: PhotosUseCase {
    
    private enum C {
        static let token = "VnEwZ1Td74Pwyk-N8a2yH8AuJAppUex8HxYYTQTpJdA"
    }
    
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
            AF.request("https://api.unsplash.com/photos/?client_id=\(C.token)",
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
}
