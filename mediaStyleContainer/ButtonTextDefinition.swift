//
//  ButtonTextDefinition.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/01.
//  Copyright © 2015年 just1factory. All rights reserved.
//

struct ButtonTextDefinition {
    
    //ボタンに入るテキスト一覧
    static func getButtonTextList() -> [String] {

        return [
            "View1",
            "View2",
            "View3",
            "View4",
            "View5",
            "View6"
        ]
    }
    
    //インデックスに対応するテキストを返す
    static func getButtonLabel(_ key: Int) -> String {
        
        let target: Array = self.getButtonTextList()
        return target[key]
    }
    
}
