//
//  TitleView.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-04-25.
//

import SwiftUI

struct TitleView: View {
    @State var isActive: Bool = false
    
    var categoryName: String
    var products: [Products]
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text(self.categoryName)
                .font(.title)
            
//            ScrollView(.horizontal, showsIndicators: false){
//                HStack{
//                    ForEach(self.products){
//                        products in
//
//                        ProductItem(products: products)
//                            .frame(width: 200)
//                            .padding(.trailing, 95)
//                    }
//                }
//            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 17), count: 2), spacing: 17){
                
                Section{
                ForEach(self.products){
                    products in
                    
                    
                    
                    NavigationLink(destination: ProductDetail(products: products), isActive: $isActive){
                        
                        ProductItem(products: products)
                            
                        
    
                    }
                }
                }
            }
        }
        
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(categoryName: "Featured Products", products: productData)
        
    }
}
