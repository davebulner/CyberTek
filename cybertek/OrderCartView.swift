//
//  OrderCartView.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-04-28.
//

import SwiftUI

struct OrderCartView: View {
    
    @ObservedObject var orderListener = OrderListener()
    
    var body: some View {
        
        NavigationView{
            List {
                Section {
                    ForEach(self.orderListener.orderCart?.items ?? []){
                        products in
                        
                        HStack{
                            Text(products.name)
                            Spacer()
                            Text("$\(products.price.clean)")
                        }//End of HStack
                        
                    }//End of ForEach
                    .onDelete {
                        (indexSet) in
                        self.deleteItems(at: indexSet)
                    }
                }
                
                Section{
                    NavigationLink(destination: CheckOutView()){
                        Text("Place Order")
                    }
                }.disabled(self.orderListener.orderCart?.items.isEmpty ?? true)
                
                
            }// End of list
            .navigationTitle("Order")
            .listStyle(GroupedListStyle())
            
        }//End of Navigation view
        
    }
    
    func deleteItems(at offsets: IndexSet){
        
        self.orderListener.orderCart.items.remove(at: offsets.first!)
        self.orderListener.orderCart.saveCartToFireStore()
        
    }
    
}

struct OrderCartView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCartView()
    }
}
