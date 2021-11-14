//
//  ProductDetailsVC.swift
//  DuppizleTest
//
//  Created by Tariq Maged on 13/11/2021.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var titleView: RoundedShadowView!
    
    //vars
    var product:Results?
    lazy var keyValueTupleArr:[(String,String)] = [
        ("Description","\(product?.name ?? "") "),
        ("Price",product?.price ?? "" ),
        ("Created At",String(product?.created_at?.split(separator: " ").first ?? "" ))
    ]
    
    let mainStackView:UIStackView = {
      let stackView = UIStackView()
      stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
      stackView.axis = .vertical
      return stackView
    }()
    let imageView:CachedImageView = {
        let iV = CachedImageView()
        iV.contentMode = .scaleAspectFit
        iV.layer.cornerRadius = 8
        iV.clipsToBounds = true
        return iV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillMainStackView()
        setupViews()
    }
    
    func setupViews(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 24),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        showCashedImage()
        view.addSubview(mainStackView)
        mainStackView.anchor(imageView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 24, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        btnBack.addTarget(self, action: #selector(btnBackPressed), for: .touchUpInside)
 
    }
    
    func showCashedImage(){
        if let imgUrl = product?.image_urls?.first{
        shouldPresentLoadingView(true)
            imageView.loadImage(urlString:imgUrl) {
                DispatchQueue.main.async {
                    self.shouldPresentLoadingView(false)
                }
            }
        }
    }
    
    func fillMainStackView(){
        keyValueTupleArr.forEach{
            let stack = createMiniStackView(key: $0.0, value: $0.1 )
            mainStackView.addArrangedSubview(stack)
        }
    }

    func createMiniStackView(key:String,value:String)->UIStackView{
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        let lblKey = UILabel()
        lblKey.textAlignment = .left
        lblKey.text = key
        lblKey.font = UIFont.boldSystemFont(ofSize: 20)
        lblKey.textColor = #colorLiteral(red: 0.9955219626, green: 0.5297186375, blue: 0.2594603598, alpha: 1)
        stackView.addArrangedSubview(lblKey)
        let lblValue = UILabel()
        lblValue.textAlignment = .center
        lblValue.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        lblValue.font = UIFont.systemFont(ofSize: 18)
        lblValue.text = value
        stackView.addArrangedSubview(lblValue)
        return stackView
    }
    
    @objc func btnBackPressed(){
        dissmissDetail()
    }

}
