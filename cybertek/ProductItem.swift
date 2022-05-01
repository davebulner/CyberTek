//
//  ProductItem.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-04-26.
//

import SwiftUI

struct ProductItem: View {
    
    var products: Products
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            
            ZStack{
                Color(UIColor.systemRed)
                    .cornerRadius(15)
                
                Image(products.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .shadow(color: Color.black, radius: 15)
            }
            
//            Image(products.imageName)
//                .resizable()
//                .renderingMode(.original)
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 200, height: 200)
//                .cornerRadius(10)
//                .shadow(radius: 12)
            
            VStack(alignment: .leading, spacing: 5){
                Text(products.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                
                Text(products.formattedPrice)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame( height: 20)
            }
        }
        
    }
}

struct ProductItem_Previews: PreviewProvider {
    static var previews: some View {
        ProductItem(products: productData[0])
    }
}
