//
//  Authentication.swift
//  Patinfly
//
//  Created by Xavier Romeu on 27/9/22.
//

import Foundation
import SwiftUI

class Authentication: ObservableObject{
    @Published var isValidated: Bool = false
    
    enum AuthenticationError: Error, LocalizedError, Identifiable{
        case invalidCredentials
        
        var id: String{
            self.localizedDescription
        }
        
        var errorDescription: String?{
            switch self{
            case .invalidCredentials:
                return NSLocalizedString("El teu usuari o contrasenya son incorrectes", comment: "")
            }
        }
    }
    
    func updateValidation(success: Bool){
        withAnimation{
            isValidated = success
        }
    }
}
