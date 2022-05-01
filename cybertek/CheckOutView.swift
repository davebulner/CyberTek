//
//  CheckOutView.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-04-28.
//

import SwiftUI

struct CheckOutView: View {
    
    @ObservedObject var orderlistener = OrderListener()
     static let paymentTypes = ["Cash", "Credit Card"]
    
    @State private var paymentType = 0

    @State private var showingPaymentAlert = false
    
    var totalPrice: Double {
        let total = orderlistener.orderCart.total
        
        return total
    }
    
    var body: some View {
        
        Form{
            Section{
                Picker(selection: $paymentType, label: Text("How Do You Want To Pay")){
                    
                    ForEach(0 ..< Self.paymentTypes.count){
                        
                        Text(Self.paymentTypes[$0])
                    }
                }
            }//End of section
            
            Section(header: Text("Total: $\(totalPrice.clean)").font(.largeTitle)){
                
                Button(action: {
                    
                    self.showingPaymentAlert.toggle()
                    self.createOrder()
                    self.emptyCart()
                    
                }) {
                    Text("Confirm Order")
                }//End of section
                
                .navigationBarTitle(Text("Payment"), displayMode: .inline)
                .alert(isPresented: $showingPaymentAlert){
                    Alert(title: Text("Order Confirmed"), message: Text("Thank you"), dismissButton: .default(Text("Ok")))
                }
            }
            .disabled(self.orderlistener.orderCart?.items.isEmpty ?? true)
        }
    }
    
    private func createOrder(){
        let order = Order()
        order.amount = totalPrice
        order.id = UUID().uuidString
        order.customerId = FUser.currentId()
        order.orderItems = self.orderlistener.orderCart.items
        order.saveOrderToFirestore()
    }
    
    private func emptyCart(){
        
        self.orderlistener.orderCart.emptyCart()
        
    }
    
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
    }
}
