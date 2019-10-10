//
//  User.swift
//  LoginApplication
//
//  Created by Abhishek Vasudev on 09/10/19.
//  Copyright © 2019 Abhishek Vasudev. All rights reserved.
//

import Foundation

//MARK:- User Model

struct User: Decodable {
    let firstName: String?
    let lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    init(from decoder: Decoder) throws {
        let all = try decoder.container(keyedBy: CodingKeys.self)
        
        if let firstName = try all.decodeIfPresent(String.self, forKey: .firstName) {
            self.firstName = firstName
        } else {
            self.firstName = "-1"
        }
        if let lastName = try all.decodeIfPresent(String.self, forKey: .lastName) {
            self.lastName = lastName
        } else {
            self.lastName = "-1"
        }
    }
}
