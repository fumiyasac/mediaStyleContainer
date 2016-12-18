//
//  ChildContainer5.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/06.
//  Copyright © 2015年 just1factory. All rights reserved.
//

import UIKit

class ChildContainer5: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sendParent5(_ sender: UIButton) {
        
        let resultDictionary: [String : String] = [
            "id" : "5",
            "color" : "FFCCCC",
            "name" : ButtonTextDefinition.getButtonLabel(4)
        ]
        self.parent?.performSegue(withIdentifier: "fromChildController", sender: resultDictionary)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
