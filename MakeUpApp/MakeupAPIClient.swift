//
//  MakeupAPIClient.swift
//  MakeUpApp
//
//  Created by TingxinLi on 12/17/18.
//  Copyright © 2018 TingxinLi. All rights reserved.
//

import Foundation

enum MakeUpError {
    case badURL(String)
    case badData(Error)
    case badDecoding(Error)
}

final class MakeupAPIClient {
    static func getMakeup(completionHandler: @escaping(([MakeUp]?, MakeUpError?) -> Void)) {
        guard let url = URL.init(string: "http://makeup-api.herokuapp.com/api/v1/products.json") else {
            completionHandler(nil,.badURL("url failed"))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, .badData(error))
            }
            
            if let data = data {
                do {
                    let MakeupData = try JSONDecoder().decode([MakeUp].self, from: data)
                    completionHandler(MakeupData,nil)
                } catch {
                    completionHandler(nil, .badDecoding(error))
                }
            }
            }.resume()
        
    }
}
