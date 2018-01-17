//
//  TaskListViewController.swift
//  BeeHive
//
//  Created by John Gambrell on 7/10/17.
//  Copyright © 2017 JPG. All rights reserved.
//

import UIKit
import Alamofire

class TaskListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskProgressCircleView: ProgressCircleView!
    
    let taskData = ["Go to Store", "Do Some Stuff", "Fill out a form", "Return to Office"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.delay(1.0) {
            self.taskProgressCircleView.animateCircle(duration: Double(self.taskProgressCircleView.percentComplete / 100))
        }
    }
    
 override func viewWillLayoutSubviews() {
        summaryView.layer.cornerRadius = 25
        let gradientLayer = CAGradientLayer()
    
        gradientLayer.frame = view.bounds
        gradientLayer.locations = [0.0, 0.30]
        //F36D43
    //F5A187
    //F39476  //F2BEAE
    
    gradientLayer.colors = [UIColor(rgb: 0xe6632c).cgColor, UIColor(rgb: 0xFA9164).cgColor]
    
    view.layer.insertSublayer(gradientLayer, at: 0)
    super.viewWillLayoutSubviews()
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
