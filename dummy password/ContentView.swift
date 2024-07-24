//
//  ContentView.swift
//  dummy password
//
//  Created by Praveen Yeddu on 20/07/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(entity: Account.entity(), sortDescriptors: [].reversed())
    
    private var accounts: FetchedResults<Account>
    
    @State var showAddAccountSheet = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                    List(accounts) { account in
                        NavigationLink(value: account) {
                            ListRowView( account: account)
                            
                        }
                    }
                .listRowSpacing(30)
                .navigationTitle("Password Manager")
                
                Spacer()
                
                HStack {
                    Button(action: {
                        showAddAccountSheet = true
                        
                    }, label: {
                        Image(systemName: "plus.square.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(Color.accentColor)
                            
                        
                    })
                    .padding(.leading, 284)
                    .padding(.top, 589)
                    .sheet(isPresented: $showAddAccountSheet) {
                        AddAccountDetailVew()
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                            .presentationCornerRadius(17)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

struct ListRowView: View {
    var account: Account
    @State var showEditAccountSheet = false
    
    var body: some View {
        HStack {
            Text(account.appName!)
                .foregroundStyle(Color.appName)
                .font(.title)
                .fontWeight(.semibold)
            
            Text("*******")
                .foregroundStyle(Color.pwd)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
        }
        .onTapGesture {
            showEditAccountSheet = true
        }
        .frame(width: 300, height: 60.19, alignment: .leading)
        .padding(.leading)
        .sheet(isPresented: $showEditAccountSheet) {
            DetaiView( account: account)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(17)
                .ignoresSafeArea()
        }
    }
}
