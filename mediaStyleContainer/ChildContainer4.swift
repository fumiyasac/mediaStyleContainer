//
//  ChildContainer4.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/06.
//  Copyright © 2015年 just1factory. All rights reserved.
//

import UIKit

class ChildContainer4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sendParent4(sender: UIButton) {
        
        let resultDictionary: [String : String] = [
            "id" : "4",
            "color" : "CCCCFF",
            "name" : ButtonTextDefinition.getButtonLabel(3)
        ]
        self.parentViewController?.performSegueWithIdentifier("fromChildController", sender: resultDictionary)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
