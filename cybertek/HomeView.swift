//
//  ContentView.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-04-25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @State var tabSlection = 1
    
    @ObservedObject var productListener = ProductListener()
    @State private var showingCart = false
    
    var categories: [String: [Products]]{
        .init(
            grouping: productListener.products,
            by: {
                $0.category.rawValue
            }
        )
            
        
    }
    
    var body: some View{
        
        
        
        TabView(selection: $tabSlection){
        NavigationView{
            
//            ImageCaro()
            
            List(categories.keys.sorted(), id: \String.self){
                key in
                
                TitleView(categoryName: "\(key) Products".uppercased(), products: self.categories[key]!)
            }
            
//                .navigationTitle(Text("CyberTek"))
                .toolbar {
                    ToolbarItemGroup(placement: .principal){
                        Image("logo").resizable().aspectRatio(contentMode: .fit).cornerRadius(5)
                    }
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: {
                            //code
                            FUser.logOutCurrentUser { (error) in
                                print("error login out user", error?.localizedDescription)
                            }
                            createProductList()
                        }, label: {
                            Text("Log Out")
                        })
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button(action: {
                            //code
                            self.showingCart.toggle()
                            
                        }, label: {
                            Image("basket")
                        })
                        .sheet(isPresented: $showingCart){
                            
                            if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                                OrderCartView()
                            }
                            else if FUser.currentUser() != nil {
                                FinishRegistrationView()
                            }else{
                                LoginView()
                            }
                            
                        }
                    }
                    
                    
                    
                }
           
            
        }// end nav
        .tabItem{
            Image(systemName: "house")
            Text("Home") }.tag(1)
        NavigationView{
            HomeView()
                .navigationTitle("home").font(.headline)
        }
            
            tabItem{
                Image(systemName: "keyboard")
                Text("Products") }.tag(2)
            NavigationView{
                HomeView()
                    .navigationTitle("home").font(.headline)
            }
            
            tabItem{
                Image(systemName: "keyboard")
                Text("Products") }.tag(2)
            NavigationView{
                HomeView()
                    .navigationTitle("home").font(.headline)
            }
        
//        .tabItem{
//            Image("basket")
//            Text("Basket") }.tag(2)
//            Button(, action: {
//                    self.showingCart.toggle()
//                })
//                .sheet(isPresented: $showingCart){
//
//                if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
//                    OrderCartView()
//                }
//                else if FUser.currentUser() != nil {
//                    FinishRegistrationView()
//                }else{
//                    LoginView()
//                }
//
//            }
//
        
        
        }
        
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
