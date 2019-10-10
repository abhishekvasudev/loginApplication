//
//  LoginViewModel.swift
//  LoginApplication
//
//  Created by Abhishek Vasudev on 09/10/19.
//  Copyright © 2019 Abhishek Vasudev. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewModelDelegate: class {
    func onFetchCompleted(_ success: Bool)
    func onFetchFailed(_ error: Error)
}


class LoginViewModel {
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private let networkManager = NetworkManager()
    private let url: String?
    private weak var delegate: LoginViewModelDelegate?
    
    private var user: User?
    
    init(_ url: String?, _ delegate: LoginViewModelDelegate?) {
        self.url = url
        self.delegate = delegate
    }
    
    //MARK:- Get User
    func getUser() {
        if let appDelegate = appDelegate, let apiKey = appDelegate.config?.apiKey, let urlString = url {
            let finalURL = "\(urlString)\(self.setFinalURL(apiKey))"
            networkManager.getResponse(for: User.self, url: finalURL) { (result) in
                switch result {
                case let .success(response):
                    DispatchQueue.main.async {
                        self.fetchUser(response)
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        self.delegate?.onFetchFailed(error)
                    }
                }
            }
        } else {
            self.delegate?.onFetchFailed(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        }
    }
    
    //MARK:- Fetch User
    private func fetchUser(_ response: User) {
        user = response
        self.delegate?.onFetchCompleted(true)
    }
    
    //MARK:- Set Final URL
    private func setFinalURL(_ apiKey: String) -> String {
        return "api-key=\(apiKey)"
    }
    
    
}
