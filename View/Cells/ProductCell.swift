//
//  ProductCell.swift
//  HyberMarket
//
//  Created by Tariq Maged on 4/17/20.
//  Copyright © 2020 Tariq Maged. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    //vars
    var countProducts = 0
    var price:Double = 0
    var oldQuantity = 0
    
    //outlets
    @IBOutlet weak var btnFev: UIButton!
    @IBOutlet weak var btnUpdate: ButtonRounded!
    @IBOutlet weak var imgViewProduct: CachedImageView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var txtFieldQuantity: CustomTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnUpdate.isEnabled = false
        btnUpdate.alpha = 0.7
    }
    
    func setupCell(product:Results?){
        guard let product = product else {return}
        lblOldPrice.attributedText = ((product.price ?? "0")).oldPriceStrikeThrough()
        
        lblPrice.text = (product.price ?? "0")
        let priceInt = String(product.price?.split(separator: " ").last ?? "0")
        price = Double(priceInt) ?? 0
        lblDescription.text = product.name
        if let urlString = product.image_urls_thumbnails?.first{
            imgViewProduct.layer.cornerRadius = 4.0
            imgViewProduct.loadImage(urlString:urlString )
        }
    }
    
    
    func adjustTextField(){
        if countProducts >= 0 {
            lblTotal.text = "\(price * Double(countProducts)) AED"
            txtFieldQuantity.text = "\(countProducts)"
            
        }else{
            countProducts = 0
        }
       fadeUpdateBtn()
    }
    
    func fadeUpdateBtn(){
        if oldQuantity == countProducts || countProducts == 0{
            btnUpdate.isEnabled = false
            btnUpdate.fadeTo(alphaValue: 0.7, withDuration: 0.3)
        }else{
            btnUpdate.fadeTo(alphaValue: 1, withDuration: 0.3)
            btnUpdate.isEnabled = true
        }
    }
    
    func resetUpdateBtn(){
        countProducts =  0
        oldQuantity = 0
        txtFieldQuantity.text = "\(countProducts)"
    }
    
    
    
    @IBAction func btnMinusClosed(_ sender: Any) {
        countProducts -= 1
        adjustTextField()
    }
    
    @IBAction func btnPlusPressed(_ sender: UIButton) {
        countProducts += 1
        adjustTextField()
    }
    
    
    
    @IBAction func btnFevoritePressed(_ sender: UIButton) {
        
    }

    
    @IBAction func btnUpdatePressed(_ sender: ButtonRounded) {
        
    }
    
   
    
   
}
