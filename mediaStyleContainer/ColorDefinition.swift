//
//  ColorDefinition.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/12/06.
//  Copyright © 2015年 just1factory. All rights reserved.
//

//
//  ColorDefinition.swift
//  goCoworkingSpaceReport
//
//  Created by 酒井文也 on 2015/09/25.
//  Copyright © 2015年 just1factory. All rights reserved.
//

/**
* WebのカラーコードからiPhoneでの色設定の値を作成する
* 本コードは下記のURLのものを使用しています。
* https://gist.github.com/arshad/de147c42d7b3063ef7bc
*/

import UIKit

struct ColorDefinition {
    
    //16進数のカラーコードをiOSの設定に変換するメソッド
    static func colorWithHexString (_ hex:String) -> UIColor {
        
        //受け取った値を大文字に変換する
        var cString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        //コードの設定に間違っている(正しい16進数表記ではない)場合はグレーカラーにする
        if cString.characters.count != 6 {
            return UIColor.gray
        }
        
        //各々のコード部分を抜き出して変換を行う
        let rString = cString.substring(to: cString.index(cString.startIndex, offsetBy: 2))
        let gString = cString[cString.index(cString.startIndex, offsetBy: 2)..<cString.index(cString.endIndex, offsetBy: -2)]
        let bString = cString[cString.index(cString.startIndex, offsetBy: 4)..<cString.index(cString.endIndex, offsetBy: 0)]
        
        //RGBの形式に直してUIColorクラスに渡す
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
}
