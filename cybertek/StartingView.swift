//
//  StartingView.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-05-01.
//

import SwiftUI

struct StartingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Welcome to CyberTek").font(.headline)
                    Spacer()
                    Image("startlogo").cornerRadius(30)
                    Spacer()
                    NavigationLink(
                        destination: LoginView().navigationBarHidden(false),
                        label: {
                            Text("Login")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(15.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                .padding(.vertical)
                        })
                        .navigationBarHidden(true)
                    
                    NavigationLink(
                        destination: LoginView().navigationBarHidden(false),
                        label: {
                            Text("Sign In")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(15.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                .padding(.vertical)
                
                        })
                        .navigationBarHidden(true)
                    
                    NavigationLink(
                        destination: HomeView().navigationBarHidden(true),
                        label: {
                            Text("Guest")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(15.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                .padding(.vertical)
                
                        })
                        .navigationBarHidden(true)
                    
                    HStack {
                        NavigationLink(destination: ImageCaro(), label: {
                            Text("About Us")
                        }).foregroundColor(Color.black)
                        Spacer()
                        Text("Terms & Conditions")
                        Spacer()
                        Text("Privacy")
                            .foregroundColor(Color.black)
                    }
                }
                .padding()
            }
        }
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}
