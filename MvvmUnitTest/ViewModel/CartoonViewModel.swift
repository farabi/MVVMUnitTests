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
    
    let isloadingObservable:Observable<Bool>
    
    init(dataProvider: DataProvider) {
        
        self.cartoonObservable = dataProvider.getCartoon()
        self.isloadingObservable = dataProvider.isLoadingVariable.asObservable().distinctUntilChanged()
    }
    
    func name() -> Observable<String> {
        
        return cartoonObservable.map({ cartoon -> String in
            return cartoon.name
        }).observeOn(MainScheduler.instance)
    }
    
    func logoName() -> Observable<String> {
        
        return cartoonObservable.map({ cartoon -> String in
            return cartoon.logoName
        }).observeOn(MainScheduler.instance)
    }
    
    func characters() -> Observable<[String]> {
        
        return cartoonObservable.map({ cartoon -> [String] in
            return cartoon.characters
        }).observeOn(MainScheduler.instance)
    }
}
