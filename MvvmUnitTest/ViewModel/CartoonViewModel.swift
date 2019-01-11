//
//  CartoonViewModel.swift
//  MvvmUnitTest
//
//  Created by Saad El Oulladi on 07/01/2019.
//  Copyright © 2019 saadeloulladi. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class CartoonViewModel {

    private let cartoonObservable:Observable<Cartoon>
    private let isLoadingVariable = Variable(false)
    
    /*var onShowLoadingHud: Observable<Bool> {
        return loadInProgress
            .asObservable()
            .distinctUntilChanged()
    }*/
    
    init(dataProvider: DataProvider) {
        
        cartoonObservable = dataProvider.getCartoon()
    }
    
    func nameDriver() -> Driver<String> {
        
        return cartoonObservable.map({ cartoon -> String in
            return cartoon.name
        }).observeOn(MainScheduler.instance)
        .asDriver(onErrorJustReturn: "")
    }
    
    func logoNameDriver() -> Driver<String> {
        
        return cartoonObservable.map({ cartoon -> String in
            return cartoon.logoName
        }).observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
    }
    
    func charactersDriver() -> Driver<[String]> {
        
        return cartoonObservable.map({ cartoon -> [String] in
            return cartoon.characters
        }).observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: [])
    }
    
    func loadingDriver() -> Driver<Bool> {
        
        return cartoonObservable.map({ cartoon -> Bool in
            return false
        }).observeOn(MainScheduler.instance)
        .asDriver(onErrorJustReturn: false)
    }
    
}
