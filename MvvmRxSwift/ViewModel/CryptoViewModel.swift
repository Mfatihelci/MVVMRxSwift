//
//  CryptoViewModel.swift
//  MvvmRxSwift
//
//  Created by Muhammed fatih Elçi on 6.12.2023.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    
    let cryptos: PublishSubject<[Crypto]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    func requestData() {
        self.loading.onNext(true)
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().dowloandCurrencies(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let crypto):
                self.cryptos.onNext(crypto)
            case.failure(let error):
                switch error {
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
            }
        }
    }
}
