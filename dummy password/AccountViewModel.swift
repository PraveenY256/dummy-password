//
//  AccountViewModel.swift
//  dummy password
//
//  Created by Praveen Yeddu on 21/07/24.
//

import SwiftUI

class AccountViewModel: ObservableObject {

    @Published var accounts: [Account] = []
    
//    init() {
//        accounts = accountsData
//    }
    
//    func addNewAccount(accountName: String, userName: String, password: String) {
//        let newAccount = Account(appTitle: accountName, password: userName, emailID: password)
//        accounts.append(newAccount)
//    }
    
    func editAccount() {
        
    }
    
    func deleteAccount(account: Account) {
        let updatedAccounts = accounts.filter{$0 != account}
        accounts = updatedAccounts
    }
}

//let accountsData = [
//    Account(appTitle: "Google", password: "asdf1234", emailID: "abcd@gmail.com"),
//    Account(appTitle: "LinkedIn", password: "jdfjei23", emailID: "efgh@gmail.com"),
//    Account(appTitle: "Twitter", password: "ejifjr4893", emailID: "effiefigh@gmail.com"),
//    Account(appTitle: "Facebook", password: "fuvbriu4839", emailID: "abcd@gmail.com"),
//    Account(appTitle: "Instagram", password: "jfe94892", emailID: "efgh@gmail.com")
//]
