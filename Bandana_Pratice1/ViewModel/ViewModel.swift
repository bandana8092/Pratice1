//
//  ViewModel.swift
//  Bandana_Pratice1
//
//  Created by Rakesh Nangunoori on 27/01/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import UIKit
import Foundation

class ViewModel: NSObject {
    static let shared :ViewModel = {
          let instance = ViewModel()
                 return instance
      }()
    
       var arrStory = [StoryModel]()
       var pageCount = 0
       var totalpages = 0
       var currentPage = 0
    
    func getPosts(completionHandler: @escaping (_ status: Error?) -> Void)
       {
           ServiceCalling.shared.getData(url: "\(SERVER_BASE_URL)\(pageCount)") { (responceData, error) in
                if error == nil
                          {
                              print("responcedata:",responceData )
                              if responceData?.object(forKey: "nbPages") != nil
                              {
                                  let pages = String(describing: responceData!.object(forKey: "nbPages")!)
                                  self.totalpages = Int(pages) ?? 0
                              }
                              if responceData?.object(forKey: "page") != nil
                              {
                                  let cuntPage = String(describing: responceData!.object(forKey: "page")!)
                                  self.currentPage = Int(cuntPage) ?? 0
                              }
                              if let arrObj = responceData?.object(forKey: "hits") as? NSArray{
                                  
                                  for dicObj in arrObj{
                                      
                                      let modelObj = StoryModel.init(postData: dicObj as! NSDictionary)
                                      self.arrStory.append(modelObj)
                                  }
                                  completionHandler(nil)
                              }
                              else{
                                  print("Data not in currect format")
                              }
                              
                              
                          }
                          else{
                              print("serevr data nil")
                              completionHandler(error)
                          }
                      }
        }
    
    //MARK: - Update Model With Selected Cell Status
    func updateSelectedStatus(arrPosts:[StoryModel], indexPath: IndexPath,completionHandler: @escaping (_ status: Error?) -> Void)
    {
        arrPosts[indexPath.row].selectedStatus = arrPosts[indexPath.row].selectedStatus ? false : true
        completionHandler(nil)
    }
    
    func getFormattedDate(strServerDate : String) -> String
    {
        let formatter = DateFormatter()//2019-11-16T09:35:52.000Z
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateFromString = formatter.date(from: strServerDate)
        
        let requiredFormat = DateFormatter()
        requiredFormat.dateFormat = "yyyy-mm-dd hh:mm a"
        let dateWithString = requiredFormat.string(from: dateFromString!)
        
        return dateWithString
    }
    
}
