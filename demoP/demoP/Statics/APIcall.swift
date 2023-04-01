//
//  APIcall.swift
//  demoP
//
//  Created by 200OK-IOS5 on 31/03/23.
//

import Foundation
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

typealias Responder = (data: Any? , error: Error? )

class APICall{
    private let apiPath = "https://dummyjson.com/"
    
    func getAPICall(endPoint: String, requestPara: [String:String], complitions: @escaping ((Responder)->())) {
       
        let semaphore = DispatchSemaphore (value: 0)
        var urlComps = URLComponents(string: "https://dummyjson.com/products?limit=10&skip=10")!
        urlComps.queryItems = requestPara.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        var request = URLRequest(url: urlComps.url!,timeoutInterval: Double.infinity)
        
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
              complitions(Responder(data: nil, error: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
            complitions(Responder(data: data, error: nil))
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()

    }
}
