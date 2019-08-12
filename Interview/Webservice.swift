//
//  Webservice.swift
//  GeniusPLaza
//
//  Created by davy ngoma mbaku on 8/10/19.
//  Copyright © 2019 davy ngoma mbaku. All rights reserved.
//

import Foundation
import UIKit

enum WebServiceError: Error {
    //more error case could be added here
    case receivedInvalidObject
}

protocol ErrorResponse: Decodable {
    var code: Int? { get set }
    var message: String? { get set }
    func isValid() -> Bool
}

extension ErrorResponse {
    func isValid() -> Bool {
        return message == nil && code == nil
    }
}

//MAR: enum to hold endpoints
enum Endpoints: String, CustomStringConvertible {
    case appleMusicEndpoint  = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/10/explicit.json"
    
    var description: String {
        return self.rawValue
    }
}

class WebService {
    static let shared = WebService()
}

struct Router {
    static func jsonData() -> String {
        return Endpoints.appleMusicEndpoint.description
    }
    
    static func pictureURL(url: String) -> String {
        return url
    }
}

class URLRequestFactory {
    static func getRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}

class ServiceRequest {
    static func perform<T>(_ request: URLRequest, resultType: T.Type,
                           completion: @escaping (_ result: T? , _ error: Error?) -> Void) where T:ErrorResponse {
        let resultRequest = request
        let session = URLSession.shared
        let task = session.dataTask(with: resultRequest as URLRequest) { (data, response, error) in
            do {
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(nil, nil)
                    }
                    return
                }
                let decoder = JSONDecoder()
                print("Result type is \(resultType)")
                let result = try decoder.decode(resultType, from: data)
                DispatchQueue.main.async {
                    result.isValid() ? completion(result, nil) : completion(nil, WebServiceError.receivedInvalidObject)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
   
    static func perform(_ request: URLRequest, completion: @escaping (_ result: Data? , _ error: Error?) -> Void) {
        let resultRequest = request
        let session = URLSession.shared
        let task = session.dataTask(with: resultRequest as URLRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(data, nil)
            }
        }
        task.resume()
    }
}


//MARK: request functions
extension WebService {
    func getDataItune(completion:@escaping (_ result: JsonResponse? , _ error: Error?) -> Void) {
        guard let url = URL(string: Router.jsonData()) else {
            return
        }
        let request = URLRequestFactory.getRequest(url: url)
        ServiceRequest.perform(request, resultType: JsonResponse.self, completion: completion)
    }
}

