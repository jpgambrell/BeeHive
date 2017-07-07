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

        
//        tasksProgressCircleView.setupIntialView(progressStrokeColor: UIColor.black, backgroundStrokeColor: UIColor.lightGray, backgroundCircleAlpa: 0.5, strokeWidth: 5, percentageComplete: 45, labelFont: UIFont(name: "Futura", size: self.tasksProgressCircleView.labelFontSize)!, labelColor: UIColor.brown )
//
//        tasksProgressCircleView.labelFontSize = 60
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.delay(1.0) {
            self.tasksProgressCircleView.animateCircle(duration: Double(self.tasksProgressCircleView.percentComplete / 100))
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
extension NSObject {
func delay(_ seconds: Double, completion: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(Int(seconds * 1000.0))) {
        completion()
    }
}
}

