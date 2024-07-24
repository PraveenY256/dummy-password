//
//  AddAccountDetailVew.swift
//  dummy password
//
//  Created by Praveen Yeddu on 21/07/24.
//

import SwiftUI

struct AddAccountDetailVew: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
 
    @State private var accountName = ""
    @State private var userName = ""
    @State private var password = ""
    @State private var encryptedPassword = Data()
    @State private var validationErrors: [String] = []
    
    private let key = Array("01234567890123456789012345678901".utf8)
    private let iv = Array("abcdefghijklmnop".utf8)
    
    
    var body: some View {
        VStack {
            VStack {
                TextField(text: $accountName) {
                    Text("Account Name")
                        .font(.callout)
                    
                }
                .overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color.background,style: StrokeStyle(lineWidth: 0.6)))
                .font(.title)
                .padding(.bottom)
                
                
                
                TextField(text: $userName) {
                    Text("Username/ Email")
                        .font(.callout)
                }
                .overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color.background,style: StrokeStyle(lineWidth: 0.6)))
                .font(.title)
                .padding(.bottom)
                
                TextField(text: $password) {
                    Text("Password")
                        .font(.callout)
                }
                .overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color.background,style: StrokeStyle(lineWidth: 0.6)))
                .font(.title)

                
            }
            .fontWeight(.semibold)
            .textFieldStyle(.roundedBorder)
            .padding(20)
            
            HStack {
                Button(action: {
                    validationErrors = PasswordValidator.validate(password: password)
                    if validationErrors.count == 0 {
                        let (encrypted, key) = encrypt(password: password)
                            
                        
                        
                        DataController().addAccount(appName: accountName, userID: userName, password: encrypted, key: key, context: managedObjContext)
                        dismiss()
                    }
                    
                }, label: {
                    Text("Add New Account")
                        .frame(width: 355, height: 50)
                        .buttonStyle(.borderedProminent)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .foregroundStyle(Color.white)
                        .font(.title3)
                        .fontWeight(.bold)
                })
                .padding(.bottom)
            }
            if !validationErrors.isEmpty {
                Text("Invalid Password:")
                     .font(.headline)
                     .foregroundStyle(Color.red)
                 List(validationErrors, id: \.self) { error in
                     Text(error)
                 }
             } 
        }
        .background(Color.newHomeBackground)
    }
}

