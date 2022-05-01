//
//  OrderListener.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-04-28.
//

import Foundation
import Firebase
import UIKit

class OrderListener: ObservableObject {
    
    @Published var orderCart: OrderCart!
    
    init(){
        
        downloadCart()
    }
    
    func downloadCart(){
        
        if FUser.currentUser() != nil{
            
            FirebaseReference(.Cart).whereField(kOWNERID, isEqualTo: FUser.currentId()).addSnapshotListener{
                (snapshot, error) in
                
                guard let snapshot = snapshot else { return }
                
                if !snapshot.isEmpty {
                    
                    let cartData = snapshot.documents.first!.data()
                    
                    getProductsFromFirestore(withIds: cartData[kPRODUCTIDS] as? [String] ?? []){
                        (allProducts) in
                        
                        let cart = OrderCart()
                        cart.ownerId = cartData[kOWNERID] as? String
                        cart.id = cartData[kID] as? String
                        cart.items = allProducts
                        self.orderCart = cart
                        
                    }
                    
                }
                
            }
        }
    
    }
    
}


func getProductsFromFirestore (withIds: [String], completion: @escaping (_ productsArray: [Products]) -> Void){
    
    var count = 0
    var productsArray: [Products] = []
    
    if withIds.count == 0 {
        
        completion(productsArray)
        return
        
    }
    
    for productsId in withIds{
    
        FirebaseReference(.ProductList).whereField(kID, isEqualTo: productsId).getDocuments{(snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty{
                
                let productsData = snapshot.documents.first!
                
                productsArray.append(Products(id: productsData[kID] as? String ?? UUID().uuidString, name: productsData[kNAME] as? String ?? "Unknown", imageName: productsData[kIMAGENAME] as? String ?? "Unkwon", category: Category(rawValue: productsData[kCATEGORY] as? String ?? "featured") ?? .featured, description: productsData[kDESCRIPTION] as? String ?? "Description is missing", price: productsData[kPRICE] as? Double ?? 0.00))
                
                count += 1
                
            }else {
                print("Have no Products")
                completion(productsArray)
            }
            
            if count == withIds.count {
                completion(productsArray)
            }
        }
        
    }
    
}
