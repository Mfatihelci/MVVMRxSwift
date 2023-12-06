//
//  WebService.swift
//  MvvmRxSwift
//
//  Created by Muhammed fatih Elçi on 6.12.2023.
//

import Foundation

enum CryptoError : Error {
    case serverError
    case parsingError
}

class WebService {
    
    func dowloandCurrencies(url: URL,completion: @escaping (Result<[Crypto],CryptoError>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(CryptoError.serverError))
            } else if let data = data {
                //neye gore decode ediceksin json tek bi tane dondurmedigi icin dizi seklinde aliyoruz.
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                }else {
                    completion(.failure(CryptoError.parsingError))
                }
            }
        }.resume()
    }
}
