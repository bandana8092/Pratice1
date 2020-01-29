//
//  StoriesViewController.swift
//  Bandana_Pratice1
//
//  Created by Rakesh Nangunoori on 27/01/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
   
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var storiesTV: UITableView!
    
    // MARK: - Var Declaration
    
     var refreshControl : UIRefreshControl!
     var isDataLoading:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalMethodClass.shared.showActivityIndicator(view: view, targetVC: self)
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        self.storiesTV.addSubview(refreshControl)
        activityIndicator.isHidden = true
        if GlobalMethodClass.shared.isConnectedToNetwork() == true {
        ViewModel.shared.getPosts { (error) in
            if error == nil
            {
                DispatchQueue.main.async {
                    GlobalMethodClass.shared.hideActivityIndicator(view: self.view)
                    self.storiesTV.reloadData()
                }
                
            }
            else{
                print("No data from server")
            }
        }
        }
        
    }
    
    @objc func pullToRefresh()
    {
        
        if ViewModel.shared.totalpages > ViewModel.shared.currentPage {
            ViewModel.shared.arrStory.removeAll()
            ViewModel.shared.pageCount = 0
            self.fetchMoreData()
            
        }
        refreshControl?.endRefreshing()
        self.storiesTV.reloadData()
        
    }
    func fetchMoreData()
       {
      if GlobalMethodClass.shared.isConnectedToNetwork() == true {
           ViewModel.shared.getPosts { (error) in
               if error == nil{
                   DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                       self.storiesTV.reloadData()
                   }
               }
           }
        }
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ViewModel.shared.arrStory.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StoriesTableViewCell
        cell.updatePostCellUI(arrStory: ViewModel.shared.arrStory, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
       }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ViewModel.shared.updateSelectedStatus(arrPosts: ViewModel.shared.arrStory, indexPath: indexPath) { (error) in
            if error == nil
            {
                let arrFiltered = ViewModel.shared.arrStory.filter{$0.selectedStatus == true}
                if arrFiltered.count > 0
                {
                    self.navigationItem.title = "SelectedRows: \(arrFiltered.count)"
                    
                }
                else{
                    self.navigationItem.title  = "SelectedRows: 0"
                }
                self.storiesTV.reloadData()
            }
            else
            {
                print("error")
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == ViewModel.shared.arrStory.count - 1 { //last row
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            if ViewModel.shared.totalpages > ViewModel.shared.currentPage {
                ViewModel.shared.pageCount += 1
                self.fetchMoreData()
             }else { //no records
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
            }
    }
    }
   /*
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
        isDataLoading = false
        
              
    }



    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        
    }
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        //Bottom Refresh
       
        if scrollView == storiesTV{

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                
                if !isDataLoading{

                  isDataLoading = true
                    if ViewModel.shared.totalpages > ViewModel.shared.currentPage {
                        ViewModel.shared.pageCount += 1
                        
                        self.fetchMoreData()
                        
                    }
                               
                              
                }
            }
        }
    }
 */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
