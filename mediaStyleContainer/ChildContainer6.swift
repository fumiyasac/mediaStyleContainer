//
//  ChildContainer6.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/06.
//  Copyright © 2015年 just1factory. All rights reserved.
//

import UIKit

class ChildContainer6: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sendParent6(_ sender: UIButton) {

        let resultDictionary: [String : String] = [
            "id" : "6",
            "color" : "FF99CC",
            "name" : ButtonTextDefinition.getButtonLabel(5)
        ]
        self.parent?.performSegue(withIdentifier: "fromChildController", sender: resultDictionary)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
