//
//  DataViewModel.swift
//  DynamicCellHeight
//
//  Created by Nagesh on 17/06/18.
//  Copyright © 2018 Nagesh Kumar Mishra. All rights reserved.
//

import Foundation
import MBProgressHUD


class  ViewModel {
    
    weak var dataView: DataTableViewController?
    var datafeed : AboutCanada?
    var paserData = APIClient()
    
    
    // Fetch data and update the tableView
    func fetchData() {
        
        self.paserData.requestData { (dataValue, status)  in
            
            DispatchQueue.main.async(execute: {
                MBProgressHUD.showAdded(to: (self.dataView?.view)!, animated: true)
            })
            switch status {
            case .pass:
                self.datafeed = dataValue
                DispatchQueue.main.async(execute: {
                    MBProgressHUD.hide(for: (self.dataView?.view)!, animated: true)
                    self.dataView?.tableView.reloadData()
                    self.dataView?.title = self.datafeed?.title
                })
                break
                
            case .fail:
                
                DispatchQueue.main.async(execute: {
                    MBProgressHUD.hide(for: (self.dataView?.view)!, animated: true)
                })
                
                break
            }
        }
    }
    
    
    // Number of row in a section, if noting return add default value to 0
    func numberOfItemsToDisplay(in section: Int) -> Int {
        
        guard (self.datafeed?.rows) != nil else {
            return 0
        }
        return (datafeed?.rows?.count)!
    }
    
}
