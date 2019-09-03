//
//  CountryFetchingService.swift
//  Concurrency Lab
//
//  Created by Jason Ruan on 9/3/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

class CountryFetchingService {
    
    //MARK: -- Static Properties
    static let manager = CountryFetchingService()
    
    //MARK: -- Internal Methods
    func getAllCountries(from urlString: String, completionHandler: @escaping (Result<Data, CountryFetchError>) -> () ) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        let dataTask = self.urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(.responseError(error!)))
                return
            }
            guard let urlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.noURLResponse))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completionHandler(.failure(.badURLResponse(urlResponse.statusCode)))
                return
            }
            completionHandler(.success(data))
        }
        dataTask.resume()
    }
    
    //MARK: Private Properties and Initializers
    private let urlSession = URLSession(configuration: .default)
    private init() {}
    
}
