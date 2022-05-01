//
//  LoginView.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-04-28.
//

import SwiftUI

struct LoginView: View {
    
    @State var showingSignUp = false
    @State var showingFinishReg = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var fullName = ""
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    
    var body: some View {
        
        VStack {
            Text("Sign In")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.bottom, .top], 20)
            
            VStack(alignment: .leading){
                
                VStack(alignment: .leading){
                    
                    if showingSignUp {
                        Text("Full Name")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(Color.init(.label))
                            .opacity(0.75)
                        
                        TextField("Enter your Full Name", text: $fullName)
                        Divider()
                    }
                    
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    TextField("Enter Your Email", text: $email)
                    Divider()
                    
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    SecureField("Enter Your Password", text: $password)
                    Divider()
                    
                    if showingSignUp {
                        Text("Repeat Password")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(Color.init(.label))
                            .opacity(0.75)
                        
                        SecureField("Repeat Password", text: $repeatPassword)
                        Divider()
                    }
                    
                    
                }.padding(.bottom, 15)//end
                    .animation(.easeOut(duration: 0.1))
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        
                        self.resetPassword()
                        
                    }, label: {
                        Text("Forgot Password")
                            .foregroundColor(Color.gray.opacity(0.5))
                        
                    })
                }//end h
                
                
                
            }
            .padding(.horizontal, 6)
            //end
            
            Button(action: {
                
                self.showingSignUp ? self.signUpUser() : self.loginUser()
                
            }, label: {
                Text(showingSignUp ? "Sign Up" : "Sign In")
                    .foregroundColor(.white)
                    .frame(minWidth: UIScreen.main.bounds.width - 120)
                    .padding()
                
            })
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.top, 45)
            //end button
            
            SignUpView(showingSignUp: $showingSignUp)
            
        }//end
        .sheet(isPresented: $showingFinishReg){
            FinishRegistrationView()
        }
        
    }
    
    private func loginUser(){
        
        if email != "" && password != ""{
            
            FUser.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                
                if error != nil {
                    print("error loging in the user:", error!.localizedDescription)
                    return
                }
                
                if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding{
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                } else {
                    
                    self.showingFinishReg.toggle()
                    
                }
            }
            
        }
        
    }
    
    private func signUpUser(){
        if email != "" && password != "" && repeatPassword != ""{
            if password == repeatPassword{
                
                FUser.registerUserWith(email: email, password: password) { (error) in
                    
                    if error != nil {
                        print("Error register user:", error!.localizedDescription)
                        return
                    }
                    
                    print("user has been Created")
                    //go back to app
                    //check if user onboaring is done
                }
                
            }else {
            print("passwords dont match")
            }
            
        } else {
            print("Email and Password must be set")
        }
        
        
    }
    
    private func resetPassword(){
        
        if email != ""{
            
            FUser.resetPassword(email: email) { (error) in
                if error != nil{
                    print("error sending reset password", error!.localizedDescription)
                    return
                }
            }
            print("please check your email")
            
        } else {
            print("email is empty")
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct SignUpView : View {
    
    @Binding var showingSignUp: Bool
    
    var body: some View {
        
        VStack {
             Spacer()
            
            HStack(spacing: 8){
            
                Text("Dont Have An Account ?")
                    .foregroundColor(Color.gray.opacity(0.5))
                
                Button(action: {
                    
                    self.showingSignUp.toggle()
                    
                }, label: {
                    Text("Sign Up")
                })
                .foregroundColor(.blue)
                
            }//end Hstack
            .padding(.top, 25)
            
        }//end Vstack
    }
}
