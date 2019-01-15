//
//  CartoonViewController.swift
//  MvvmUnitTest
//
//  Created by Saad El Oulladi on 07/01/2019.
//  Copyright © 2019 saadeloulladi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CartoonViewController: UIViewController {

    @IBOutlet weak var cartoonNameLabel: UILabel!
    @IBOutlet weak var cartoonImageView: UIImageView!
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: CartoonViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.charactersTableView.register
        charactersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        ///charactersTableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: String(describing: UITableViewCell.self))
        self.viewModel = CartoonViewModel(dataProvider: DataProvider())
        self.dataBinding()
    }
    
    func dataBinding() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.name()
                 .bind(to:self.cartoonNameLabel.rx.text)
                 .disposed(by:disposeBag)
        
        viewModel.logoName()
                 .map{ UIImage(named: $0) }
                 .bind(to: cartoonImageView.rx.image)
                 .disposed(by: disposeBag)
        
        viewModel.isloadingObservable.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
        
        // Fill characters tableView
        viewModel.characters().bind(to: charactersTableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, characterName, cell in
            
            cell.textLabel?.text = characterName
            
            }.disposed(by: disposeBag)
    }

}
