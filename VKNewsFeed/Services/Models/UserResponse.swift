//
//  UserResponse.swift
//  VKNewsFeed
//
//  Created by Maxim Spiridonov on 15/05/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import Foundation


struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
