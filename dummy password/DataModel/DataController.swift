//
//  DataController.swift
//  dummy password
//
//  Created by Praveen Yeddu on 22/07/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "AccountModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!!! WUHU!!!")
        } catch {
            print("We could not save the data...")
        }
    }
    
    func delete(context: NSManagedObjectContext, account: Account) {
       context.delete(account)
        save(context: context)
    }
    
    func addAccount(appName: String, userID: String, password: Data, key: Data, context: NSManagedObjectContext) {
        let account = Account(context: context)
        account.id = UUID()
        account.appName = appName
        account.userID = userID
        account.password = password
        account.key = key
            
        save(context: context)
    }
    
    func editAccount(account: Account, userID: String, password: Data, key: Data, context: NSManagedObjectContext) {
        account.userID = userID
        account.password = password
        account.key = key
        
        save(context: context)
    }
}
