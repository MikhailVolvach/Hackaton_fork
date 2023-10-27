//
//  ImageManager.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 26.10.2023.
//

import Foundation



protocol ImageManagerDescription {
    func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> ())
}

final class ImageManager: ImageManagerDescription {
    static let shared = ImageManager()
    private init () {}
    
    private let networkImageQueue = DispatchQueue(label: "networkImageQueue", attributes: .concurrent)
    
    func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        let mainTreadCompletion: ((Result<Data, Error>) -> ()) = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        networkImageQueue.async {
            guard let imageData = try? Data(contentsOf: url) else {
                mainTreadCompletion(.failure(ImageManagerError.unexpectedError))
                return
            }
            mainTreadCompletion(.success(imageData))
        }
    }
}
