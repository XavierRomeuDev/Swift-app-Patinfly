//
//  RentListView.swift
//  Patinfly
//
//  Created by Xavier Romeu on 19/12/22.
//

import SwiftUI

struct RentListView: View {
    
    @FetchRequest (entity: RentEntity.entity(), sortDescriptors:[NSSortDescriptor(key: "date_start", ascending: false), NSSortDescriptor(key: "uuid", ascending: true)]) var rents: FetchedResults<RentEntity>
    
    @State private var showMenu: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    List{
                        ForEach(rents) { rent in
                            RentRowView(name: rent.name ?? "", date: dateFormat(date: rent.date_start ?? ""), distance: rent.km_use).padding(.horizontal, 15)
                        }
                    }.navigationTitle("Rent History")
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
                }.onAppear(){
                    ApiService.checkServerStatusWithCompletion(){
                        result in
                        
                        switch result{
                        case .success(_):
                            ApiService.userRent(withToken: APIConstants.token){
                                result in
                                
                                switch result{
                                case .success(let rentList):
                                    DataController.shared.deleteRents()
                                    DataController.shared.saveRents(rentList: rentList)
                                case .failure(let error):
                                    print(error)
                                }
                                
                            }
                        case .failure(let networkError):
                            print(networkError)
                        }
                    }
                }
                    GeometryReader{ _ in
                        HStack{
                            Spacer()
                            
                            SideMenuView()
                                .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                                .animation(.easeInOut(duration: 0.5), value: showMenu)
                        }
                    }
                }
            }
        }
    }
    
    struct RentRowView: View{
        
        let name: String
        let date: String
        let distance: Float
        
        var body: some View{
            VStack{
                VStack(alignment: .leading, spacing: 15){
                    HStack{
                        Text("Scooter: ").bold().foregroundColor(.orange).font(.body)
                        Text(name).bold().foregroundColor(.black).font(.body)
                    }
                    
                    HStack{
                        Text("Date: ").bold().foregroundColor(.orange).font(.body)
                        Text(date).foregroundColor(.black).font(.body)
                    }
                    
                    HStack{
                        Text("Distance: ").bold().foregroundColor(.orange).font(.body)
                        Text(String(distance)).foregroundColor(.black).font(.body)
                        Text("m").foregroundColor(.black).font(.body)
                    }
                    
                }
                
            }
        }
    }
    
    struct RentListView_Previews: PreviewProvider {
        static var previews: some View {
            RentListView()
        }
    }
