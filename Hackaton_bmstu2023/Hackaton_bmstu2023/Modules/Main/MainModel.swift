//
//  MainModel.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 26.10.2023.
//

import Foundation

final class MainModel {
    private let wordsNetworkManager = MainNetworkManager.shared
    
    func loadData(completion: @escaping (Result<MainData, Error>) -> ()) {
        wordsNetworkManager.getData { result in
            completion(result)
        }
    }
}
