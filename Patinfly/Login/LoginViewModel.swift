//
//  LoginViewModel.swift
//  Patinfly
//
//  Created by deim on 20/9/22.
//

import Foundation

class LoginViewModel: ObservableObject{
    
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?

    var loginDisable: Bool{
        credentials.email.isEmpty || credentials.password.isEmpty || credentials.esMarcat == false
    }
    
    func login(completition: @escaping (Bool) -> Void){
        showProgressView = true
        APIService.shared.login(credentials: credentials){[unowned self] (result: Result<Bool, Authentication.AuthenticationError>) in showProgressView = false
            switch result{
                case .success:
                    completition(true)
                case .failure(let authError):
                    credentials = Credentials()
                    error = authError
                    completition(false)
            }
        }
    }
    
}
