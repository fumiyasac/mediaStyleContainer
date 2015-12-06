//
//  ContainerDefinition.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/01.
//  Copyright © 2015年 just1factory. All rights reserved.
//

//ContainerViewの識別用enum
enum ContainerDefinition {
    
    //コンテナ番号の名称
    case FirstContainer
    case SecondContainer
    case ThirdContainer
    case FourthContainer
    case FifthContainer
    case SixthContainer
    
    //状態対応するの値を返す
    func returnValue() -> Int {
        
        //各々のケース
        switch (self) {
            case .FirstContainer:
                return 0
            case .SecondContainer:
                return 1
            case .ThirdContainer:
                return 2
            case .FourthContainer:
                return 3
            case .FifthContainer:
                return 4
            case .SixthContainer:
                return 5
        }
    }
    
}
