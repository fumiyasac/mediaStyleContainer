//
//  ChildContainer1.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/06.
//  Copyright © 2015年 just1factory. All rights reserved.
//

import UIKit

class ChildContainer1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendParent1(sender: UIButton) {
        
        let resultDictionary: [String : String] = [
            "id" : "1",
            "color" : "CCFF66",
            "name" : ButtonTextDefinition.getButtonLabel(0)
        ]
        self.parentViewController?.performSegueWithIdentifier("fromChildController", sender: resultDictionary)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
