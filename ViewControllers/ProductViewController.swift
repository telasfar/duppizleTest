//
//  ProductViewController.swift
//  DuppizleTest
//
//  Created by Tariq Maged on 13/11/2021.
//

import UIKit
import Combine

class ProductViewController: UIViewController {
    
    @IBOutlet weak var productTableView: TanibleView!
    
    //vars
    var productViewModel = ProductViewModel()
    private var cancelable = Set<AnyCancellable>()
    var productModel:ProductModel?{
        didSet{
            productTableView.reloadData()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModelToView()
    }
    
    func setupViews(){
        let taxonNib = UINib(nibName: "ProductCell", bundle: nil)
        productTableView.register(taxonNib, forCellReuseIdentifier: "ProductCell")
        productTableView.direction = .right
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.tableFooterView = UIView()
    }
    
    func bindViewModelToView() {
        productViewModel.fetchProducts()
        productViewModel.$product
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] product in
                self?.productModel = product
            })
            .store(in: &cancelable)
        
        let stateValueHandler: (ProductViewModelState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.shouldPresentLoadingView(true)
            case .finishedLoading:
                self?.shouldPresentLoadingView(false)
            case .error:
                self?.shouldPresentLoadingView(true)
                self?.alertUser(message: "Error Occured")
            }
        }
        
        productViewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &cancelable)
    }

    
}

extension ProductViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productModel?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.setupCell(product: productModel?.results?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let productDetailVc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as? ProductDetailsVC{
            productDetailVc.product = productModel?.results?[indexPath.row]
           presentDetail(productDetailVc)
    }
}
 
}
