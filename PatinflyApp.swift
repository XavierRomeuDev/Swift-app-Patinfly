//
//  PatinflyApp.swift
//  Patinfly
//
//  Created by deim on 20/9/22.
//

import SwiftUI

@main
struct PatinflyApp: App {
    
    @StateObject var authentication = Authentication()
    
    let dataController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated{
                ScooterListView().environmentObject(authentication)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }else{
                SplashScreen().environmentObject(authentication)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }
            
        }
    }
}
