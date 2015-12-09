//
//  ResultController.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/06.
//  Copyright © 2015年 just1factory. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    
    //Container送られてきたUIColor, ボタン名
    var sendColor: String! = ""
    var sendLabel: String! = ""
    
    //Outlet
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var viewName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ColorDefinition.colorWithHexString("EEEEEE")
        
        //Containerから受け取った情報を表示
        self.colorLabel.backgroundColor = ColorDefinition.colorWithHexString(self.sendColor)
        self.viewName.text = self.sendLabel
    }
    
    @IBAction func backParentAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
