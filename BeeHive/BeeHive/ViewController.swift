//
//  ViewController.swift
//  BeeHive
//
//  Created by John Gambrell on 6/15/17.
//  Copyright © 2017 JPG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tasksProgressCircleView: ProgressCircleView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        tasksProgressCircleView.animateCircle(duration: 1.0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

