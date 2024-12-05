//
//  ScooterDetailView.swift
//  Patinfly
//
//  Created by Xavier Romeu on 22/11/22.
//

import SwiftUI
import MapKit

struct ScooterDetailView: View {
    
    let scooter: ScooterEntity

    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.155440105238064, longitude: 1.1087023235714373), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @FetchRequest (entity: UserEntity.entity(), sortDescriptors:[]) var user:FetchedResults<UserEntity>

    var body: some View {
        
        let locations = [Location(name: scooter.name ?? "", coordinate: CLLocationCoordinate2D(latitude: scooter.latitude, longitude: scooter.longitude))]
        let lastScooterRent: String = UserDefaults.standard.string(forKey:"scooter") ?? ""
        
        VStack{
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: locations){ location in
                MapMarker(coordinate: location.coordinate)
            }.frame(width: 400, height: 300)
            
            Spacer()
                   
            Text(scooter.name ?? "")
                  
            Spacer()
            
            if(APIConstants.scooterUUID == scooter.uuid){
                if(user[0].scooter == nil || user[0].scooter == scooter){
                                            
                    if (scooter.on_rent == false && scooter.state == "ACTIVE" && scooter.battery_level > 10){
                            
                        if(lastScooterRent == scooter.uuid){
                            if DataController.shared.show{
                                Text("Total rent time: \(DataController.shared.time)")
                                Spacer()
                            }
                        }
                                
                        Button(action: {

                            UserDefaults.standard.set(scooter.uuid, forKey: "scooter")

                            ApiService.checkServerStatusWithCompletion(){
                                result in
                                
                                switch result{
                                case .success(_):
                                    ApiService.scooterOnRent(withToken: APIConstants.token){
                                        result in
                                        
                                        switch result{
                                        case .success(_):
                                            DataController.shared.startRent(user: user[0], scooter: scooter)
                                        case .failure(let error):
                                            print(error)
                                        }
                                    
                                    }
                                case .failure(let networkError):
                                    print(networkError)
                                }
                            }
                        }){
                            RentButton(label: "Start rent", buttonColor: .blue)
                        }
                    } else{
                        Text("Scooter actually on rent")
                        Spacer()
                    }
                               
                    if (user[0].scooter == scooter && scooter.on_rent == true){

                        Button(action: {

                            ApiService.checkServerStatusWithCompletion(){
                                result in
                                
                                switch result{
                                case .success(_):
                                    ApiService.scooterEndRent(withToken: APIConstants.token){
                                        result in
                                        
                                        switch result{
                                        case .success(_):
                                            DataController.shared.endRent(user: user[0], scooter: scooter)
                                        case .failure(let error):
                                            print(error)
                                        }
                                        
                                    }
                                case .failure(let networkError):
                                    print(networkError)
                                }
                            }
                        }){
                            RentButton(label: "End rent", buttonColor: .red)
                        }
                        }
                    } else{
                        Text("You already have a scooter on rent")
                        Spacer()
                    }
            }else{
                Text("Another person have this scooter on rent")
                Spacer()
            }
                                      
        }.onAppear(){
            
            ApiService.checkServerStatusWithCompletion(){
                result in
                
                switch result{
                case .success(_):
                    ApiService.scooterDataWithCompletion(withToken: APIConstants.token, scooterToken: scooter.uuid ?? ""){
                        result in
                        
                        switch result{
                        case .success(let scooterData):
                            DataController.shared.refreshScooter(scooterData: scooterData, scooter: scooter)
                        case .failure(let error):
                            print(error)
                        }
                }
                case .failure(let networkError):
                    print(networkError)
                }
            }
            

            LocationManager.shared.getUserLocation{ location in
                DispatchQueue.main.async{
                    region.center.latitude = location.coordinate.latitude
                    region.center.longitude = location.coordinate.longitude
                }
            }
        }
    }
}

struct Location: Identifiable{
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

