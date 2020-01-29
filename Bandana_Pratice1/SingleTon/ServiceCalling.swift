//
//  ServiceCalling.swift
//  Bandana_Pratice1
//
//  Created by Rakesh Nangunoori on 27/01/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import UIKit

class ServiceCalling: NSObject {
    static let shared :ServiceCalling = {
        let instance = ServiceCalling()
               return instance
    }()
    
    func getData(url:String,complitionHandler:@escaping(_ response:NSDictionary?,_ error:NSError?)-> Void){
        print(url)
        let url1 = URL(string: url)
        let request = URLRequest(url: url1!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (Data, urlResponse, error) in
            if Data == nil{
                 print("No Data available")
            }else{
                do{
                     let jsonResult = try JSONSerialization.jsonObject(with: Data!, options: .mutableContainers)
                    complitionHandler(jsonResult as? NSDictionary,nil)
                    print(jsonResult)
                   
                    
                }catch{
                    complitionHandler(nil, error as NSError)
                     print("error")
                }
            }
        }
        task.resume()
    }

}
