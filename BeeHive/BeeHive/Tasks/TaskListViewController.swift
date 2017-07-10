//
//  TaskListViewController.swift
//  BeeHive
//
//  Created by John Gambrell on 7/10/17.
//  Copyright © 2017 JPG. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource {

   @IBOutlet weak var tableView: UITableView!
    
     let taskData = ["Go to Store"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return taskData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mapTaskCell", for: indexPath) as? MapTaskCell else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            cell.progressHeaderView.type = .Header
        }
        else {
            cell.progressHeaderView.type = (indexPath.row == taskData.count - 1) ? .Footer : .Other
        }
        
        cell.taskLabel.text = taskData[indexPath.row]
        
        return cell as MapTaskCell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
