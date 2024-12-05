//
//  ContentView.swift
//  Patinfly
//
//  Created by deim on 20/9/22.
//

import SwiftUI
import MapKit

struct ScooterListView: View {
    
    //Carrega de dades i mostrarles
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.132093087476754, longitude: 1.2445664179123956), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    //Fetch data from database
    @FetchRequest (entity: ScooterEntity.entity(), sortDescriptors:[NSSortDescriptor(key: "name", ascending: true)]) var scooters: FetchedResults<ScooterEntity>
    @FetchRequest (entity: UserEntity.entity(), sortDescriptors:[]) var user:FetchedResults<UserEntity>


    @State private var showMenu: Bool = false
    
    var body: some View {
        
        NavigationView{
            ZStack{
                VStack{
                    List{
                        ForEach(scooters) { scooter in
                            NavigationLink{
                                ScooterDetailView(scooter: scooter)
                            } label: {
                                ScooterRowView(name: scooter.name ?? "", state: scooter.state ?? "", distance: calculateDistance(lat1: region.center.longitude, lon1: region.center.latitude, lat2: scooter.latitude, lon2: scooter.longitude), battery_level: scooter.battery_level, on_rent: scooter.on_rent)
                            }
                        }
                    }.navigationTitle("Scooters")
                     .navigationBarTitleDisplayMode(.inline)
                     .toolbar{
                        Button{
                            self.showMenu.toggle()
                        } label: {
                            Image(systemName: "text.justify")
                                .font(.title)
                                .foregroundColor(.orange)
                        }
                    }
                }
                GeometryReader{ _ in
                    HStack{
                        Spacer()
                        
                        SideMenuView()
                            .offset(x: showMenu ? 0: UIScreen.main.bounds.width)
                            .animation(.easeInOut(duration: 0.5), value: showMenu)
                    }
                }
            }
        }.onAppear(){
            
            ApiService.checkServerStatusWithCompletion(){
                result in
                
                switch result{
                case .success(_):
                    ApiService.scooterListWithCompletion(withToken: APIConstants.token){
                        result in
                        
                        switch result{
                        case .success(let scooterList):
                            if(!user[0].on_rent){
                                DataController.shared.deleteScooters()
                            }
                            DataController.shared.saveScooter(scooterList: scooterList)
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


struct ScooterRowView: View{
    
    let name: String
    let state: String
    let distance: String
    let battery_level: Float
    let on_rent: Bool
    
    var body: some View{
        VStack{
            VStack(alignment: .leading, spacing: 15){
                HStack{
                    Text(name).bold().foregroundColor(.black).font(.body)
                    Spacer()
                    Label(
                        title: {Text ("")},
                        icon: {
                            printBatteryIcon(battery: battery_level)
                        })
                    }
                
                }
               
                HStack{
                    Label(
                        title: {Text ("")},
                        icon: { printScooter(state: state, on_rent: on_rent)})
                    Spacer()
                    HStack{
                        Text(distance)
                        Text("m").padding(10)
                    }.frame(alignment: .trailing)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScooterListView()
    }
}
