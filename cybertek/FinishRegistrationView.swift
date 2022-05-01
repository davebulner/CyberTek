//
//  FinishRegistration.swift
//  cybertek
//
//  Created by Dave Bulner on 2022-04-28.
//

import SwiftUI

struct FinishRegistrationView: View {
    
    @State var fullName = ""
    @State var telephone = ""
    @State var Address = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        Form{
            Section(){
                Text("Complete Registration")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding([.top, .bottom], 20)
                
                TextField("Full Name", text: $fullName)
                TextField("Telephone Number", text: $telephone)
                TextField("Address", text: $Address)
                
            }//end section
            
            Section(){
                Button(action: {
                    self.completeRegistration()
                }, label: {
                    Text("Complete Registration")
                })
            }.disabled(!self.fieldsCompleted())
        }//End of Form
    }
    
    private func fieldsCompleted() -> Bool {
        return self.fullName != "" && self.telephone != "" && self.Address != ""
    }
    
    private func completeRegistration(){
        
        updateCurrentUser(withValues: [kFULLNAME: fullName, kFULLADDRESS: Address, kPHONENUMBER: telephone, kONBOARD: true]) { (error) in
            
            if error != nil {
                
                print("error updating user: ", error!.localizedDescription)
                return
            }
            
            self.presentationMode.wrappedValue.dismiss()
        }
        
    }
}

struct FinishRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishRegistrationView()
    }
}
