//
//  StoryModel.swift
//  Bandana_Pratice1
//
//  Created by Rakesh Nangunoori on 27/01/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import Foundation

class StoryModel {
    
       var title = ""
       var createDate = ""
       var selectedStatus = false
       
       init(postData : NSDictionary)
       {
           if let aTitle = postData.object(forKey: serverKeys.keyTitle){
            self.title = (aTitle as? String)!
           }
           if let aCreatedDate = postData.object(forKey: serverKeys.keyCreatedDate){
               self.createDate = aCreatedDate as! String
           }
       }


}

