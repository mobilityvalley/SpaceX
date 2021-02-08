//
//  Network.swift
//  Space
//
//  Created by Eric Granger on 06/02/2021.
//

import Foundation

class Network {
    
    // MARK: - Methods
    static func request<T: Decodable>(url: URL,
                                      type: T.Type,
                                      completion: @escaping (T?, NetworkError?) -> Void) {
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil, .requestError)
                }
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
            
            if statusCode != 200 {
                DispatchQueue.main.async {
                    completion(nil, .requestError)
                }
                return
            }
            
            do {
                guard let jsonData = data else {
                    DispatchQueue.main.async {
                        completion(nil, .invalidJSON)
                    }
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom { (decoder) -> Date in
                    let value = try decoder.singleValueContainer().decode(String.self)
                    
                    let formatter = ISO8601DateFormatter()
                    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                    
                    if let date = formatter.date(from: value) {
                        return date
                    }
                    
                    throw NetworkError.dateParseError
                }
                
                let typedObject: T? = try decoder.decode(T.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(typedObject, nil)
                }
            } catch {
                print(error)
                
                DispatchQueue.main.async {
                    completion(nil, .parseError)
                }
            }
        }.resume()
    }
}
