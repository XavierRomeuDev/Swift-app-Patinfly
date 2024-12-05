//
//  SideMenuView.swift
//  Patinfly
//
//  Created by Xavier Romeu on 19/12/22.
//

import SwiftUI

struct SideMenuView: View {
    
    var body: some View {
        VStack{
            Text("Menu")
                .font(.title)
                .foregroundColor(.white)
            
            Divider()
                .frame(width: 200, height: 2)
                .background(Color.orange)
                .padding(.horizontal, 16)
                .blur(radius: 0.5)
            
            NavigationLink(destination: ScooterListView().navigationBarHidden(true)){
                Text("Scooters")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 5)
            }
            
            NavigationLink(destination: RentListView().navigationBarHidden(true)){
                Text("Rent history")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 5)
            }
            
            Spacer()
            
        }.padding(32)
            .background(Color.black)
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
