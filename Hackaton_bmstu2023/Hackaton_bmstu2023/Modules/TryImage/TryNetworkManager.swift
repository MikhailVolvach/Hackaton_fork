//
//  TryNetworkManager.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 27.10.2023.
//

import UIKit

struct Service: Decodable {
    let imageUrl: String
}
enum NetworkManagerErrors: Error {
    case unexpectedError
    case EmptyData
}

protocol NetworkManagerDelegate {
    func loadData(complition: @escaping (Result<Service, Error>) -> ())
}

final class NetworkManager: NetworkManagerDelegate {
    
    static let shared = NetworkManager()
    private init () {}
    
    func loadData( complition: @escaping (Result<Service, Error>) -> ()) {
        guard let url = URL(string: "http://84.201.134.49:9988/view/cat.jpeg") else {
            complition(.failure(NetworkManagerErrors.unexpectedError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                complition(.failure(error))
                
                return
            }
            guard let data = data else {
                complition(.failure(NetworkManagerErrors.EmptyData))
                
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let request = try decoder.decode(Service.self, from: data)
                complition(.success(request))
            } catch let error {
                complition(.failure(error))
            }
        }.resume()
    }
    
    
    func post(image: UIImage) {
        guard let url = URL(string: "http://84.201.134.49:9988/upload") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Создаем граничные данные для формата multipart/form-data
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Формируем тело запроса
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)

        if let imageData = image.jpegData(compressionQuality: 0.9) {
            body.append(imageData)
        }

        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Устанавливаем тело запроса
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Обработка ответа от сервера
            if let data = data,
               let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
        }.resume()
    }

}

