//
//  Config.swift
//  LoginApplication
//
//  Created by Abhishek Vasudev on 09/10/19.
//  Copyright © 2019 Abhishek Vasudev. All rights reserved.
//

import Foundation

struct Config: Decodable {
    let apiKey: String
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "API_KEY"
    }
}
