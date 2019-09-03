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
    func getData(from urlString: String, completionHandler: @escaping (Result<Data, NetworkError>) -> () ) {
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
    
    func getAllCountries(completionHandler: @escaping (Result<[Country], CountryError>) -> () ) {
        CountryFetchingService.manager.getData(from: countryEndpoint) { (result) in
            switch result {
            case let .success(data):
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completionHandler(.success(countries))
                } catch {
                    completionHandler(.failure(.jsonDecodingError(error)))
                }
            case let.failure(networkError):
                completionHandler(.failure(.networkError(networkError)))
            }
        }
    }
    
    //MARK: Private Properties and Initializers
    private let urlSession = URLSession(configuration: .default)
    private init() {}
    private let countryEndpoint = "https://restcountries.eu/rest/v2/name/united"
}
