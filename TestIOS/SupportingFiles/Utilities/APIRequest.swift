//
//  APIRequest.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

import Foundation

typealias CompletionHandler = (Data) -> Void
typealias FailureHandler = (APIError) -> Void

struct EmptyRequest: Encodable {}
struct EmptyResponse: Decodable {}

enum HTTPMethod: String {
    case get
    case put
    case delete
    case post
}

class APIRequest<Parameters: Encodable, Model: Decodable> {
    
    static func call(
        path: String,
        method: HTTPMethod,
        authorized: Bool,
        queryItems: [URLQueryItem]? = nil,
        parameters: Parameters? = nil,
        completion: @escaping CompletionHandler,
        failure: @escaping FailureHandler
    ) {
        if !NetworkMonitor.shared.isReachable {
            failure(APIError(message: NSLocalizedString("No Internet connection", comment: ""), status: 0))
            return
        }
        
        guard let url = buildURL(path: path, queryItems: queryItems) else {
            failure(APIError(message: NSLocalizedString("Failed to create URL", comment: ""), status: 0))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let parameters = parameters {
            do {
                request.httpBody = try JSONEncoder().encode(parameters)
            } catch {
                failure(APIError(message: NSLocalizedString("Error encoding request parameters", comment: ""),
                                 status: 0))
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                failure(APIError(message: NSLocalizedString("Failed to get a valid response", comment: ""), status: 0))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                failure(APIError(message: NSLocalizedString("Failed to get a valid response", comment: ""), status: 0))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                failure(APIError(message: NSLocalizedString("Server error", comment: ""),
                                 status: httpResponse.statusCode))
                return
            }
            
            guard let data = data else {
                failure(APIError(message: NSLocalizedString("No data received from the server", comment: ""),
                                 status: httpResponse.statusCode))
                return
            }
            
            completion(data)
        }
        task.resume()
    }
    
    private static func buildURL(
        path: String,
        queryItems: [URLQueryItem]?
    ) -> URL? {
        let scheme: String? = Bundle.main.infoDictionary?["API_SCHEME"] as? String
        let host: String? = Bundle.main.infoDictionary?["API_HOST"] as? String
        let port: String? = Bundle.main.infoDictionary?["API_PORT"] as? String
        if scheme != nil || host != nil || port != nil {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = path
            components.port = Int(port!)
            components.queryItems = queryItems
            return components.url
        } else {
            return nil
        }
    }
}
