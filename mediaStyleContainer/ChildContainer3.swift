//
//  ChildContainer3.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/06.
//  Copyright © 2015年 just1factory. All rights reserved.
//

import UIKit

class ChildContainer3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendParent3(sender: UIButton) {
        
        let resultDictionary: [String : String] = [
            "id" : "3",
            "color" : "FFCC99",
            "name" : ButtonTextDefinition.getButtonLabel(2)
        ]
        self.parentViewController?.performSegueWithIdentifier("fromChildController", sender: resultDictionary)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
