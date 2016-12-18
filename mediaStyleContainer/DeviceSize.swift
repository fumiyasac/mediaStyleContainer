//
//  DeviceSize.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/01.
//  Copyright © 2015年 just1factory. All rights reserved.
//

import UIKit

struct DeviceSize {
    
    //CGRectを取得
    static func bounds() -> CGRect {
        return UIScreen.main.bounds
    }
    
    //画面の横サイズを取得
    static func screenWidth() -> Int {
        return Int(UIScreen.main.bounds.size.width)
    }
    
    //画面の縦サイズを取得
    static func screenHeight() -> Int {
        return Int(UIScreen.main.bounds.size.height)
    }
    
}

