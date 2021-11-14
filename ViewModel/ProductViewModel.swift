//
//  ProductViewModel.swift
//  DuppizleTest
//
//  Created by Tariq Maged on 13/11/2021.
//

import Foundation
import Combine

enum ProductViewModelState: Equatable {
    case loading
    case finishedLoading
    case error
}

final class ProductViewModel {
    enum Section { case players }

    @Published private(set) var product: ProductModel?
    @Published private(set) var state: ProductViewModelState = .loading
  
    private var cancelable = Set<AnyCancellable>()
    var productService:ProductServiceProtocol
    
    init(productService: ProductServiceProtocol = ProductServices.instance) {
        self.productService = productService
    }

    func fetchProducts() {
        state = .loading
        let productCompletionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure:
                self?.state = .error
            case .finished:
                self?.state = .finishedLoading
            }
        }
        
        productService.getProducts()
            .sink(receiveCompletion: productCompletionHandler, receiveValue: { [weak self] product in
                self?.product = product
            })
            .store(in: &cancelable)
    }
}
