//
//  DataTableViewController.swift
//  DynamicCellHeight
//
//  Created by Nagesh on 17/06/18.
//  Copyright © 2018 Nagesh Kumar Mishra. All rights reserved.
//

import UIKit

let kReuseIdentifier = "reuseIdentifier"
let KestimatedRowHeight: CGFloat = 87

class DataTableViewController: UITableViewController {
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialViewSetp()
        self.viewModel.fetchData()
    }
    
    func initialViewSetp()  {
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = KestimatedRowHeight
        self.viewModel.dataView = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    @IBAction func refreshButtonAction(_ sender: Any) {
        
        self.viewModel.fetchData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItemsToDisplay(in: section)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier, for: indexPath) as! DataTableViewCell
        cell.setData(rows: (self.viewModel.datafeed?.rows![indexPath.row])!)
        return cell
    }
    
}
