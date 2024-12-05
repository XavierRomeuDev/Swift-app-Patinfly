//
//  LoginView.swift
//  Patinfly
//
//  Created by deim on 20/9/22.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.verticalSizeClass) var heightSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthSizeClass: UserInterfaceSizeClass?
    
    @StateObject private var loginModelView = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    
    @FetchRequest (entity: UserEntity.entity(), sortDescriptors:[]) var user:FetchedResults<UserEntity>

    var body: some View {
        
        if heightSizeClass == .regular {
            NavigationView{
                VStack{
                    Spacer()
                    Image(uiImage: UIImage(named:"loginPage") ?? UIImage()).padding(.vertical, 80)
                        Text("Patinfly").font(.largeTitle).foregroundColor(Color("PrimaryColor"))
                        TextField("Adreça de correu", text: $loginModelView.credentials.email).keyboardType(.emailAddress)
                        SecureField("Contrasenya", text:$loginModelView.credentials.password)
                        if loginModelView.showProgressView{
                            ProgressView()
                        }
                            
                        Toggle("Condicions", isOn: $loginModelView.credentials.esMarcat).padding(.horizontal, 40)
                            
                        Button("Sign in"){
                            loginModelView.login{
                                success in
                                authentication.updateValidation(success: success)
                                if user.isEmpty{
                                    DataController.shared.saveUser(email: loginModelView.credentials.email, password: loginModelView.credentials.password)
                                }
                        }
                                
                    }.disabled(loginModelView.loginDisable)
                    .padding(20)
                            
                    NavigationLink(destination: ConditionsView()){
                        Text("Consultar condicions")
                    }.padding(.vertical, 10)
                            
                }.padding(.horizontal, 60)
                 .padding(.vertical, 20)
                 .autocapitalization(.none)
                 .textFieldStyle(RoundedBorderTextFieldStyle())
                 .disabled(loginModelView.showProgressView)
                 .alert(item: $loginModelView.error){
                    error in Alert(title: Text("Error validació"), message: Text(error.localizedDescription))
                }
            }
        }
        
        else if heightSizeClass == .compact {
            NavigationView{
                VStack{
                    Image(uiImage: UIImage(named:"loginPage") ?? UIImage())
                        Text("Patinfly").font(.largeTitle).foregroundColor(Color("PrimaryColor"))
                        TextField("Adreça de correu", text: $loginModelView.credentials.email).keyboardType(.emailAddress)
                        SecureField("Contrasenya", text:$loginModelView.credentials.password)
                        if loginModelView.showProgressView{
                            ProgressView()
                        }
                            
                        Toggle("Condicions", isOn: $loginModelView.credentials.esMarcat).padding(.horizontal, 150)
                            
                        Button("Sign in"){
                            loginModelView.login{
                                success in
                                authentication.updateValidation(success: success)
                                if user.isEmpty{
                                    DataController.shared.saveUser(email: loginModelView.credentials.email, password: loginModelView.credentials.password)
                                }
                            }
                                
                    }.disabled(loginModelView.loginDisable)
                            
                    NavigationLink(destination: ConditionsView()){
                        Text("Consultar condicions")
                    }
                            
                }.padding(.horizontal, 20)
                 .autocapitalization(.none)
                 .textFieldStyle(RoundedBorderTextFieldStyle())
                 .disabled(loginModelView.showProgressView)
                 .alert(item: $loginModelView.error){
                    error in Alert(title: Text("Error validació"), message: Text(error.localizedDescription))
                }
            }
        }
        
    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
                .previewInterfaceOrientation(.portrait)
            LoginView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
