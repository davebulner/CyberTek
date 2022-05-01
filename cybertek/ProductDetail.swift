//
//  ProductDetail.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-04-26.
//

import SwiftUI

struct ProductDetail: View {
    
    @State private var showingAlert = false;
    @State private var showingLogin = false;
    
    var products: Products
    
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: false ){
            
            ZStack(alignment: .bottom){
                Image(products.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                
            }
            
            VStack(alignment: .leading, spacing: 5){
                Text(products.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                
                Text(products.formattedPrice)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame( height: 20)
                
                Text(products.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(5)
                    .padding()
                
            }
            
            HStack{
                Spacer()
                OrderButton(showAlert: $showingAlert, showLogin: $showingLogin, products: products)
                Spacer()
                    .padding(.top, 50)
            }
            
            
        }// end of scrollview
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Added to Cart"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        ProductDetail(products: productData.first!)
        
    }
}

struct OrderButton : View {
    
    @ObservedObject var orderListener = OrderListener()
    
    @Binding var showAlert: Bool
    @Binding var showLogin: Bool
    
    
    var products: Products
    
    var body : some View {
        Button(action: {
            
            if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                
                self.showAlert.toggle()
                self.addItemsToCart()
                
            }
            else {
                self.showLogin.toggle()
            }
            
            
        }) {
            Text("Add to Cart")
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(10)
        .sheet(isPresented: self.$showLogin) {
            
            if FUser.currentUser() != nil {
                FinishRegistrationView()
            }else{
                LoginView()
            }
            
        }
        
    }
    
    private func addItemsToCart(){
        
        var orderCart: OrderCart!
        
        
        if self.orderListener.orderCart != nil {
            
            orderCart = self.orderListener.orderCart
        
        } else {
            
            orderCart = OrderCart()
            orderCart.ownerId = FUser.currentId()
            orderCart.id = UUID().uuidString
            
        }
        
        
        orderCart.add(self.products)
        orderCart.saveCartToFireStore()
        
    }
    
}
