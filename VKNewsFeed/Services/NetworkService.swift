//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Maxim Spiridonov on 12/05/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import Foundation

final class NetworkService {
    
    private let authService: AuthService
    
    
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }

    func getFeed() {
       
        
        guard let token = authService.token else { return }
        let params = ["filters": "post, photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        let url = self.url(from: API.newsFeed, params: allParams)
       
        print(url)
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = params.map({ URLQueryItem(name: $0, value: $1) })
        
        return components.url!
    }
}
