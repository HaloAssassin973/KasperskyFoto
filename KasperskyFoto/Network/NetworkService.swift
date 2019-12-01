//
//  NetworkService.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 28/11/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import Foundation

class NetworkService {
    
    // построение запроса данных по URL
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)  {
        
        let parameters = self.prepareParaments(searchTerm: searchTerm)
        let url = self.url(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        print(url)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID dc1bcc94279ed5b3be81b9f5b7188d01565f5e9eefad81f9fb9b805daf5dec30"
        return headers
    }
    
    private func prepareParaments(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["q"] = searchTerm
        parameters["key"] = "14440344-8ea717118a9d30883a3aa8edd"
        parameters["image_type"] = "photo"
        parameters["order"] = "latest"
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pixabay.com"
        components.path = "/api"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
