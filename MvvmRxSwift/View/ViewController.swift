//
//  ViewController.swift
//  MvvmRxSwift
//
//  Created by Muhammed fatih Elçi on 6.12.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    let cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()//rxswiten geliyo bu suru call attigimiz icin hafizada durmamasi greken ve aslinda temizlenmesi icin bunu dispose ediyoruz
    var cryptoList = [Crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        //tableView.delegate = self
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        setupBinding()
        cryptoVM.requestData()
    }
    
    private func setupBinding() {
        //direk bind islemi manuel sekilde islemler yapmayalim diye datayi direk olarak gorunume baglama ozelligi var bu her gorunum icin olmayabilir ama indicator tableview gibi ogelerde var.tableviewde reloadata yapmayip direk geldigi gibi tableviewde gosterilir.
        cryptoVM
            .loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        //publish ettigimiz ogeleri gozlemlememiz gerekiyo
        cryptoVM
            .error
        
        //hangi trade bunun yapilmasini sorar on islemi
            .observe(on: MainScheduler.asyncInstance)//bu islemi otomatik olarak yapar
            .subscribe { errorString in
                print(errorString)
            }.disposed(by: disposeBag)
        //hangi veri tipini sakliyosa closure olarak verir ve errorstring artik ne geliyosa icine verebilirim
        
//        //Bu kod bind edilmeden onceki hali
//        cryptoVM
//            .cryptos
//            .observe(on: MainScheduler.asyncInstance)
//            .subscribe { cryptos in
//                self.cryptoList = cryptos
//                self.tableView.reloadData()
//            }.disposed(by: disposeBag)//subsrice secerken onnext completionu secmeliyiz
        
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: TableViewCell.self)) {row,item,cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
     */
    
}

