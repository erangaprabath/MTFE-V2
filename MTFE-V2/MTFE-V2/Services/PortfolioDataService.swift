//
//  PortfolioDataService.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-24.
//

import Foundation
import CoreData
class portfolioDataService{
    
    private let container:NSPersistentContainer
    private let containerName:String = "portfolioContainer"
    private let entityName:String = "PortfolioEntity"
    
    
    @Published var saveEntities:[PortfolioEntity] = []
    
    init(){
        container = NSPersistentContainer(name:containerName)
        container.loadPersistentStores{ (_,error) in
            if let error = error{
                print("Error loading core data!!!\(error)")
            }
            self.getPortfolio()
            
        }
    }
    
    
    func updatePortfolio(coin:CoinModel,amount:Double){
        if let entity = saveEntities.first(where: {$0.coinID == coin.id})
        {
            if amount > 0 {
                update(entity: entity, amount: amount)
            }
            else{
                delete(entity: entity)
            }
        }else{
            add(coin: coin, amount: amount)
        }
       
    }
    
    
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do{
          saveEntities = try container.viewContext.fetch(request)
        }catch let error{
            print("Erro fetching core data!!\(error)")
        }
        
        
    }
    

    
    
    private func add(coin:CoinModel,amount:Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
        
    }
    private func update(entity:PortfolioEntity,amount:Double){
        entity.amount = amount
        applyChanges()
        
    }
    private func delete(entity:PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save(){
        do{
            try container.viewContext.save()
        }catch let error{
            print("error of saving\(error)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
   
}
