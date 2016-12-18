//
//  ChildContainer2.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/06.
//  Copyright © 2015年 just1factory. All rights reserved.
//

import UIKit

class ChildContainer2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendParent2(_ sender: UIButton) {
        
        let resultDictionary: [String : String] = [
            "id" : "2",
            "color" : "6699FF",
            "name" : ButtonTextDefinition.getButtonLabel(1)
        ]
        self.parent?.performSegue(withIdentifier: "fromChildController", sender: resultDictionary)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
