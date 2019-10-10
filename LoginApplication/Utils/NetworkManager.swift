//
//  NetworkManager.swift
//  LoginApplication
//
//  Created by Abhishek Vasudev on 09/10/19.
//  Copyright © 2019 Abhishek Vasudev. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    //MARK:- Get Response from server
    func getResponse<T: Decodable>(for: T.Type = T.self,
                                   url: String,
                                   _ completion: @escaping (Result<T, Error>) -> Void) {
        sendRequest(url: url) { (data, response, error) in
            guard let data = data else {
                return completion(.failure(error ?? NSError(domain: "\(url)", code: -1, userInfo: nil)))
            }
            do {
                let decoder = JSONDecoder()
                try completion(.success(decoder.decode(T.self, from: data)))
            } catch let decodingError {
                print(decodingError.localizedDescription)
                completion(.failure(decodingError))
            }
        }
    }
    
    //MARK:- Send Request to API
    private func sendRequest(url: String, _ completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: "\(url)") else { return }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}
