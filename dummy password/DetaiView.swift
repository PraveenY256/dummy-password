//
//  DetaiView.swift
//  dummy password
//
//  Created by Praveen Yeddu on 20/07/24.
//

import SwiftUI

struct DetaiView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var account: Account
    
    
    @State private var userName :String = ""
    @State private var password : String = ""
    @State private var decryptedPassword: String = ""
    @State var isSecureTextfield: Bool = true
    @State private var validationErrors: [String] = []
    
    private let key = Array("01234567890123456789012345678901".utf8)
    private let iv = Array("abcdefghijklmnop".utf8)
    
    var body: some View {
        VStack {
            HStack{
                Text("Account Details")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
                    .padding()
                Spacer()
            }
            
            VStack {
                HStack {
                    Text("Account type")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.pwd)
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    Text(account.appName!)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.leading)
                    Spacer()
                }
            }
            .padding(.bottom)
            
            VStack {
                HStack {
                    Text("Username/ Email")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.pwd)
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    TextField(account.userID!, text: $userName)
                        .onAppear {
                            userName = account.userID!
                            
                            if let decrypted = decrypt(encryptedPassword: account.password!, data: account.key!) {
                                password = decrypted
                            }
                        }
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.leading)
                    Spacer()
                }
            }
            .padding(.bottom)
            
            VStack{
                HStack {
                    Text("Password")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.pwd)
                        
                    Spacer()
                }
                HStack {
                    if isSecureTextfield {
                        SecureField("Password", text: $password)
                    } else {
                        TextField(password, text: $password)
                    }
                }.overlay(alignment: .trailing) {
                    Image(systemName: isSecureTextfield ? "eye.slash" : "eye")
                        .onTapGesture {
                            isSecureTextfield.toggle()
                        }
                        .foregroundStyle(Color.pwd)
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .font(.title2)
            .fontWeight(.semibold)
        }
        
        HStack {
            Button(action: {
                validationErrors = PasswordValidator.validate(password: password)
                if validationErrors.isEmpty {
                    let (encrypted, key) = encrypt(password: password)
                    
                    DataController().editAccount(account: account, userID: userName, password: encrypted, key: key, context: managedObjContext)
                    
                    dismiss()
                }
            }, label: {
                Text("Save")
                
                    .buttonStyle(.borderedProminent)
                    .frame(width: 154, height: 44)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 24.0))
                    .foregroundStyle(Color.white)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
            })
            if !validationErrors.isEmpty {
                Text("Invalid Password:")
                     .font(.headline)
                     .foregroundStyle(Color.red)
                 List(validationErrors, id: \.self) { error in
                     Text(error)
                 }
             }
            
            
            Button(action: {
                DataController().delete(context: managedObjContext, account: account)
                dismiss()
                
                
            }, label: {
                Text("Delete")
                    .buttonStyle(.borderedProminent)
                    .frame(width: 154, height: 44)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 24.0))
                    .foregroundStyle(Color.white)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
            })
        }
        
    }
}
