//
//  ScrollViewDefinition.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/01.
//  Copyright © 2015年 just1factory. All rights reserved.
//

//ScrollViewの識別用enum
enum ScrollViewDefinition: Int {
    
    //スクロールビューの名称
    case ButtonArea, ContentsArea
    
    //状態に対応する値を返す
    func returnValue() -> Int {
        return self.rawValue
    }
    
}