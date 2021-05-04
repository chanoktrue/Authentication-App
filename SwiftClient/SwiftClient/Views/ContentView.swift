//
//  ContentView.swift
//  SwiftClient
//
//  Created by Thongchai Subsaidee on 3/5/2564 BE.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var accountListVM = AccountListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Spacer()
                        Image(systemName: loginVM.isAuthenticated ? "lock.fill" : "lock.open")
                    }
                    
                    TextField("Username", text: $loginVM.username)
                    SecureField("Password", text: $loginVM.password)
                    
                    HStack {
                        Spacer()

                        Button("Login") {
                            loginVM.login()
                        }
                        .padding()
                        Button("Signout") {
                            loginVM.logout()
                            accountListVM.accounts.removeAll()
                        }
                        .padding()
                        Spacer()
                    }
                }
                .buttonStyle(PlainButtonStyle())
                VStack {
                    Spacer()
                    if loginVM.isAuthenticated && accountListVM.accounts.count > 0 {
                        List(accountListVM.accounts, id: \.id) { account in
                            HStack {
                                Text("\(account.name)")
                                Spacer()
                                Text(String(format: "$%.2f", account.balance))
                            }
                        }
                        .listStyle(PlainListStyle())
                    }else {
                        Text("Login to see your accounts!")
                    }
                    
                    Spacer()
                    Button("Get Accounts") {
                        accountListVM.getAllAccounts()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear{
                
            }
            .navigationTitle("Login")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
