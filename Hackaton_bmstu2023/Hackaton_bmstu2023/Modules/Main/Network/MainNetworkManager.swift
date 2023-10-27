//
//  MainNetworkManager.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 26.10.2023.
//

import Foundation

protocol MainNetworkManagerProtocol {
    func getData(completion: @escaping (Result<MainData, Error>) -> ())
}

final class MainNetworkManager: MainNetworkManagerProtocol {
    
    static let shared = MainNetworkManager()
    private init() {}
    //FIXME: - добавить URL
    func getData(completion: @escaping (Result<MainData, Error>) -> ()) {
        guard let url = URL(string: "") else {
            completion(.failure(NetworkManagerError.badUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkManagerError.emptyData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let mainData = try decoder.decode(MainData.self, from: data)
                completion(.success(mainData))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
