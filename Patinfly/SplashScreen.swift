//
//  SplashScreen.swift
//  Patinfly
//
//  Created by Xavier Romeu on 4/10/22.
//

import SwiftUI

struct SplashScreen: View {
    
    @StateObject var authentication = Authentication()
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @FetchRequest (entity: ScooterEntity.entity(), sortDescriptors:[]) var scooters:FetchedResults<ScooterEntity>
    @FetchRequest (entity: UserEntity.entity(), sortDescriptors:[]) var user:FetchedResults<UserEntity>

    var body: some View {
        
        if self.isActive{
            if authentication.isValidated{
                if user[0].on_rent{
                    ScooterDetailView(scooter: user[0].scooter ?? scooters[0])
                }else{
                    ScooterListView()
                }
            }else{
                LoginView()
            }
        } else{
            VStack{
                VStack{
                    Image(uiImage: UIImage(named:"Logo") ?? UIImage())
                    Text("Patinfly").font(.title)
                }
                 .scaleEffect(1.0)
                 .opacity(opacity)
                 .onAppear{withAnimation(.easeIn(duration: 1.2)){
                     self.size = 1.0
                     self.opacity = 1.0
                    }
                 }
            }.onAppear{
                

                if !user.isEmpty {
                    authentication.isValidated = user[0].is_validated
                }

                ApiService.checkServerStatusWithCompletion(){
                    result in
                    
                    switch result{
                    case .success(_):
                        ApiService.scooterListWithCompletion(withToken: APIConstants.token){
                            result in
                            
                            switch result{
                            case .success(let scooterList):
                                if scooters.isEmpty{
                                    DataController.shared.saveScooter(scooterList: scooterList)
                                }
                            case .failure(let error):
                                print(error)
                            }
                        }
                    case .failure(let networkError):
                        print(networkError)
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0){
                    withAnimation{
                        
                        self.isActive = true
                        
                        
                    }
                }
            }
        }
    }
}


struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen().previewInterfaceOrientation(.portrait)
        SplashScreen().previewInterfaceOrientation(.landscapeLeft)
    }
}
