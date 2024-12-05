//
//  DataController.swift
//  Patinfly
//
//  Created by Xavier Romeu on 15/11/22.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    
    static let shared = DataController()
    
    let container = NSPersistentContainer(name:"Model")
    
    var show = false
    var time = DateInterval(start: Date.now, end: Date.now)
    
    init(inMemory: Bool = false){
        
        container.loadPersistentStores{
            description, error in
            if let error = error{
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveScooter(scooterList: ScootersAPI){
        
        scooterList.scooters.forEach{ (scooters) in
            // NSManagedObjectContext
            let scooter = ScooterEntity(context: container.viewContext)
            scooter.uuid = scooters.uuid
            scooter.state = scooters.state
            scooter.on_rent = scooters.on_rent
            scooter.name = scooters.name
            scooter.longitude = scooters.longitude
            scooter.latitude = scooters.latitude
            scooter.km_use = scooters.km_use
            scooter.id = scooters.uuid
            scooter.date_last_maintenance = scooters.date_last_maintenance ?? ""
            scooter.battery_level = scooters.battery_level
            try? self.container.viewContext.save()
        }
    }
    
    
    func refreshScooter(scooterData: ScootersAPI, scooter: ScooterEntity){
        
        // NSManagedObjectContext
        scooterData.scooters.forEach{ (scooters) in
            
            scooter.uuid = scooters.uuid
            scooter.state = scooters.state
            scooter.on_rent = scooters.on_rent
            scooter.name = scooters.name
            scooter.longitude = scooters.longitude
            scooter.latitude = scooters.latitude
            scooter.km_use = scooters.km_use
            scooter.id = scooters.uuid
            scooter.date_last_maintenance = scooters.date_last_maintenance ?? ""
            scooter.battery_level = scooters.battery_level
            try? self.container.viewContext.save()
        }
    }
    
    func deleteScooters(){
        let managedContext = container.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ScooterEntity")
        fetchRequest.returnsObjectsAsFaults = false

        do{
              let results = try managedContext.fetch(fetchRequest)
              for managedObject in results
              {
                  let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                  managedContext.delete(managedObjectData)
              }
          } catch let error as NSError {
              print(error)
          }
    }
  
    //cridar al fer login para guardar user
    func saveUser(email: String, password: String){
        // NSManagedObjectContext
        let user = UserEntity(context: container.viewContext)
        user.email_address = email
        user.password = password
        user.rent_time = ""
        user.is_validated = true
        user.on_rent = false
        user.start_rent = nil
        user.end_rent = nil
        try? self.container.viewContext.save()
    }
    
    func startRent(user: UserEntity, scooter: ScooterEntity){
        user.scooter = scooter
        user.on_rent = true
        user.start_rent = Date.now
        scooter.on_rent = true
        scooter.user = user
        try? self.container.viewContext.save()
    }
    
    func endRent(user: UserEntity, scooter: ScooterEntity){
        show = true
        user.scooter = nil
        user.on_rent = false
        user.end_rent = Date.now
        scooter.on_rent = false
        scooter.user = nil
        time = DateInterval(start: user.start_rent ?? Date.now, end: user.end_rent ?? Date.now)
        try? self.container.viewContext.save()
    }
    
    func saveRents(rentList: UserRents){
        
        rentList.rents.forEach{ (rent) in
            
            let rents = RentEntity(context: container.viewContext)

            rents.id = rent.uuid
            rents.uuid = rent.scooter.uuid
            rents.state = rent.scooter.state
            rents.on_rent = rent.scooter.on_rent
            rents.name = rent.scooter.name
            rents.longitude = rent.scooter.longitude
            rents.latitude = rent.scooter.latitude
            rents.km_use = rent.scooter.km_use
            rents.date_last_maintenance = rent.scooter.date_last_maintenance ?? ""
            rents.battery_level = rent.scooter.battery_level
            rents.date_start = rent.date_start
            rents.date_stop = rent.date_stop ?? ""
            try? self.container.viewContext.save()
        }
    }

    func deleteRents(){
        let managedContext = container.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RentEntity")
        fetchRequest.returnsObjectsAsFaults = false

        do{
              let results = try managedContext.fetch(fetchRequest)
              for managedObject in results
              {
                  let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                  managedContext.delete(managedObjectData)
              }
          } catch let error as NSError {
              print(error)
          }
    }
    
}

//scooterDetailView
    //actualitzar scooter onAppear de scooterDetailView
    //recargar dades de scooter a scooterDetailView

//splashScreen
    //al obrir app crash attempt to insert nil?
    //despues de fer un rent i tornar a obrir la app crashea - relacionat en dalt?

//scooterListView
    //al fetch request de coreData filtrar per nom de scooter
