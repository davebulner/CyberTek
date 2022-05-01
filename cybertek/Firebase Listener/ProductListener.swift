//
//  ProductListener.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-04-26.
//

import Foundation
import Firebase

class ProductListener: ObservableObject{
    
    @Published var products: [Products] = []
    
    init(){
        downloadProducts()
        
    }
    
    func downloadProducts() {
        
        FirebaseReference(.ProductList).getDocuments {(snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            
            if !snapshot.isEmpty {
                self.products = ProductListener.productFromDictionary(snapshot)
                
            }
        }
        
    }
    
    static func productFromDictionary(_ snapshot: QuerySnapshot) -> [Products]{
        
        var allProducts: [Products] = []
        
        for snapshot in snapshot.documents{
            let productData = snapshot.data()
            
            allProducts.append(Products(id: productData[kID] as? String ?? UUID().uuidString, name: productData[kNAME] as? String ?? "unknown", imageName: productData[kIMAGENAME] as? String ?? "Unknown", category: Category(rawValue: productData[kCATEGORY] as? String ?? "Featured") ?? .featured, description: productData[kDESCRIPTION] as? String ?? "Description is missing ", price: productData[kPRICE] as? Double ?? 0.0))
        }
        return allProducts
    }
}
