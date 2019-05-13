//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Maxim Spiridonov on 12/05/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import Foundation


protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        
        let params = ["filters": "post, photo"]
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            
            response(decoded?.response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard
            let data = from
//            let response = try? decoder.decode(type.self, from: data)
        else { return nil }
        do {
            let response = try decoder.decode(type.self, from: data)

            print("response \(response)")
        } catch DecodingError.dataCorrupted(let context) {
            print(DecodingError.dataCorrupted(context))
        } catch DecodingError.keyNotFound(let key, let context) {
            print(DecodingError.keyNotFound(key,context))
        } catch DecodingError.typeMismatch(let type, let context) {
            print(DecodingError.typeMismatch(type,context))
        } catch DecodingError.valueNotFound(let value, let context) {
            print(DecodingError.valueNotFound(value,context))
        } catch let error{
            print(error)
        }
        
        return nil
    }
}
