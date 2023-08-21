//
//  localFileManager.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-21.
//

import Foundation
import SwiftUI
  
class localFileManager{
    static let instance = localFileManager()
    
    private init(){
        
    }
    
    func saveImage(uiImage:UIImage,imageName:String,folderName:String){
        createFloder(folderName: folderName)
        guard
            let data = uiImage.pngData(),
            let url = getUrlForImage(imageName: imageName, folderName: folderName)
        else{ return }

        do{
            try  data.write(to: url)
        } catch let error{
            print("error.imageName\(imageName). \(error)")
        }
    }
    
    func getImageFromsaving(imageName:String,folderName:String) -> UIImage?{
        guard let url = getUrlForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else{
            return nil
        }
        return UIImage(contentsOfFile: url.path )
    }
    
    private func createFloder(folderName:String){
        guard let url = getUrlForFolder(name: folderName)else { return }
        
        if !FileManager.default.fileExists(atPath: url.path){
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true,attributes: nil)
                
            }catch let error{
                print("error\(error)")
            }
        }
    }
    private func getUrlForFolder(name:String) -> URL?{
        
     guard   let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        .first else{
         return nil
         
     }
        return url.appendingPathComponent(name)

    }
    
    private func getUrlForImage(imageName:String,folderName:String) -> URL?{
        guard let folderUrl = getUrlForFolder(name: folderName) else{
            return nil
            
        }
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
}
