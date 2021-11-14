//
//  ProductServices.swift
//  DuppizleTest
//
//  Created by Tariq Maged on 13/11/2021.
//

import Foundation
import Combine


enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

 protocol ProductServiceProtocol {
    func getProducts() -> AnyPublisher<ProductModel, Error>
}

class ProductServices:ProductServiceProtocol{
    
    
    static let instance = ProductServices() //Singleton Design patteren
        
        func getProducts() -> AnyPublisher<ProductModel, Error> {
            
            var dataTask: URLSessionDataTask?
            
            let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
            let onCancel: () -> Void = { dataTask?.cancel() }

            return Future<ProductModel, Error> { [weak self] promise in
                guard let urlRequest = self?.getUrlRequest() else {
                    promise(.failure(ServiceError.urlRequest))
                    return
                }
                
                dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                    guard let data = data else {
                        if let error = error {
                            promise(.failure(error))
                        }
                        return
                    }
                    do {
                        let players = try JSONDecoder().decode(ProductModel.self, from: data)
                        promise(.success(players))
                    } catch {
                        promise(.failure(ServiceError.decode))
                    }
                }
            }
            .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        }
    
    private func getUrlRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ey3f2y0nre.execute-api.us-east-1.amazonaws.com"
        components.path = "/default/dynamodb-writer"
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 10.0
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
    func testfetchProductss(complition: @escaping (_ status:Bool,_ product:ProductModel?)->Void){
        guard let urlRequest = getUrlRequest() else {return}
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, err) in
            if let data = data{
                do{
                    let responseModel = try JSONDecoder().decode(ProductModel.self, from: data)
                    complition(true,responseModel)
                }catch{
                    complition(false,nil)
                    debugPrint(error.localizedDescription)
                }
            }else{
                complition(false,nil)
            }
        }
        task.resume()
    }
    
}
