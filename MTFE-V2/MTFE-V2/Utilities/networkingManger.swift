//
//  networkingManger.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-20.
//

import Foundation
import Combine

class networkingManger {
    
    enum networkingError:LocalizedError{
        case badURLResponse(url:URL)
        case unKnown
        
        var errorDescription: String?{
            switch self{
            case .badURLResponse(url: let url): return "[😰] Bad Response From URL:\(url)"
            case .unKnown: return "[⚠️] Unkonwn error occured"
            }
        }
    }
    
    static func donwload (url:URL) -> AnyPublisher <Data, Error> {
      return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({
                try handelUrlRespose(output: $0,url: url)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handelUrlRespose(output:URLSession.DataTaskPublisher.Output,url:URL ) throws -> Data{
        guard let respose = output.response as? HTTPURLResponse,
              respose.statusCode >= 200 && respose.statusCode < 300 else {
            throw networkingManger.networkingError.badURLResponse(url:  url )
        }
        return output.data
    }
    
    static func handelCompletion(completion:Subscribers.Completion<Error>){
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
