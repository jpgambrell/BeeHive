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
        tasksProgressCircleView.percentageComplete = 60
        tasksProgressCircleView.circleLayer.strokeEnd = 0
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        delay(1.0) {
            self.tasksProgressCircleView.animateCircle(duration: 0.3)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delay(_ seconds: Double, completion: @escaping ()->Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(Int(seconds * 1000.0))) {
            completion()
        }
    }

}

