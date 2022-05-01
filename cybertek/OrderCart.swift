//
//  OrderCart.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-04-28.
//

import Foundation
import Firebase

class OrderCart: Identifiable {
    
    
    var id: String!
    var ownerId: String!
    var items: [Products] = []
    
    var total: Double {
        if items.count > 0 {
            return items.reduce(0) {$0 + $1.price}
        } else {
            return 0.0
        }
    }
    
    func add(_ item: Products){
        items.append(item)
    }
    
    func remove(_ item: Products){
        
        if let index = items.firstIndex(of: item){
            
            items.remove(at: index)
        }
        
    }
    
    func emptyCart(){
        
        self.items = []
        saveCartToFireStore()
        
    }
    
    func saveCartToFireStore(){
        
        FirebaseReference(.Cart).document(self.id).setData(cartDictionaryFrom(self))
        
    }
    
}


func cartDictionaryFrom(_ cart: OrderCart) -> [String: Any]{
    
    var allProductsIds: [String] = []
    
    for products in cart.items{
        
        allProductsIds.append(products.id)
        
    }
    
    return NSDictionary(objects: [cart.id,
                                  cart.ownerId,
                                 allProductsIds],
                        
                        forKeys: [kID as NSCopying,
                                  kOWNERID as NSCopying,
                                  kPRODUCTIDS as NSCopying]) as! [String : Any]
    
    
}
