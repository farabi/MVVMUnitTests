//
//  DataProvider.swift
//  MvvmUnitTest
//
//  Created by Saad El Oulladi on 07/01/2019.
//  Copyright © 2019 saadeloulladi. All rights reserved.
//

import UIKit
import RxSwift

class DataProvider {
    
    let isLoadingVariable = Variable(false)
    
    func getCartoon() -> Observable<Cartoon> {

        return Observable.create { observer -> Disposable in

            self.isLoadingVariable.value = true
            
            // Delay the result to simulate a network call
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                self.isLoadingVariable.value = false
                let cartoonModel = Cartoon(name: "The Marvelous Misadventures of Flapjack",
                                           logoName: "Flapjack_logo",
                                           characters: ["Flapjack",
                                                        "Captain K'nuckles",
                                                        "Bubbie",
                                                        "Peppermint Larry",
                                                        "Doctor Julius Barber"])
                observer.onNext(cartoonModel)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }

    }

}
