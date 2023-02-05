//
//  WebService.swift
//  CryptoSwiftUI
//
//  Created by Sezer on 5.02.2023.
//

import Foundation

class WebService{
    func downloadCurrencies(url: URL, completion: @escaping(Result<[CryptoCurrency]?, DownloderError>) -> Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
                completion(.failure(.badUrl))
            }
            
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else{
                return completion(.failure(.dataParseError))
            }
            
            completion(.success(currencies))
        }.resume()
    }
}

enum DownloderError : Error{
    case badUrl
    case noData
    case dataParseError
}
