//
//  coinImgeServices.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-20.
//

import Foundation
import SwiftUI
import Combine

class coinImageServices{
    
    @Published var image:UIImage? = nil
    var imageSubscription:AnyCancellable?
    private var coin:CoinModel
    private let fileManager = localFileManager.instance
    private let folderName = "Coins_Images"
    private let imageName:String
    
    init(coin:CoinModel){
    
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()

    }
    private func getCoinImage(){
        
        if let SavedImage = fileManager.getImageFromsaving(imageName:imageName, folderName: folderName){
            image = SavedImage
            print("retriving Images")
      
        }else{
           
            downloadCoinImge()
            print("downloading images")
        }
    }
    private func downloadCoinImge(){
        guard let url = URL(string: coin.image)
        else{ return }
        
      imageSubscription = networkingManger.donwload(url: url)
            .tryMap({(data) -> UIImage? in
                return UIImage(data: data)
            })

            .sink(receiveCompletion: networkingManger.handelCompletion,receiveValue: { [weak self] (returnImage) in
                
                guard let self = self, let downloadImage = returnImage else{ return }
                self.image = downloadImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(uiImage: downloadImage, imageName: self.imageName, folderName: self.folderName)
            })

        
    }
}
