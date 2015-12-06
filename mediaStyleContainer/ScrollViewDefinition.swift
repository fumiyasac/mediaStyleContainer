//
//  ScrollViewDefinition.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/01.
//  Copyright © 2015年 just1factory. All rights reserved.
//

//ScrollViewの識別用enum
enum ScrollViewDefinition {
    
    //スクロールビューの名称
    case ButtonArea
    case ContentsArea
    
    //状態対応するの値を返す
    func returnValue() -> Int {
        
        //各々のケース
        switch (self) {
            case .ButtonArea:
                return 0
            case .ContentsArea:
                return 1
        }
    }
    
}