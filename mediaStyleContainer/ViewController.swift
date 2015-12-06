//
//  ViewController.swift
//  mediaStyleContainer
//
//  Created by 酒井文也 on 2015/11/30.
//  Copyright © 2015年 just1factory. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    //コンテンツ表示用ScrollViewに入れるContainer数
    let containerCount:Int! = 6
    
    //動くラベル
    var slidingLabel: UILabel!
    
    //スクロールビューの配置ボタン
    var headerButton: UIButton!
    
    //動くラベルのY座標＆高さ
    let slidingLabelPosY: Int = 41
    let slidingLabelHeight: Int = 4
    
    //現在状態を入れる
    var containerPosition: ContainerDefinition!
    
    //ボタン配置用Scrollview
    @IBOutlet var buttonScrollView: UIScrollView!
    
    //ボタン配置用ScrollviewのY座標＆高さ
    let buttonScrollViewPosY: Int = 64
    let buttonScrollViewHeight: Int = 45
    
    //コンテンツ表示用ScrollView
    @IBOutlet var contentsScrollView: UIScrollView!
    
    //コンテンツ表示用ScrollViewのY座標＆高さ
    var contentsScrollViewPosY: Int!
    var contentsScrollViewHeight: Int!
    
    //コンテンツ表示Conteiner
    @IBOutlet var firstContainer: UIView!
    @IBOutlet var secondContainer: UIView!
    @IBOutlet var thirdContainer: UIView!
    @IBOutlet var fourthContainer: UIView!
    @IBOutlet var fifthContainer: UIView!
    @IBOutlet var sixthContainer: UIView!
    
    //スクロールカウンター
    //var scrollCounter: Int!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //初期値の計算を行う
        self.calcContentsScrollViewSize()
        
        //ボタン表示用ScrollViewの位置決定
        self.buttonScrollView.frame = CGRectMake(
            CGFloat(0),
            CGFloat(self.buttonScrollViewPosY),
            CGFloat(DeviceSize.screenWidth()),
            CGFloat(self.buttonScrollViewHeight)
        )
        
        //コンテンツ表示用ScrollViewの位置決定
        self.contentsScrollView.frame = CGRectMake(
            CGFloat(0),
            CGFloat(self.contentsScrollViewPosY),
            CGFloat(DeviceSize.screenWidth()),
            CGFloat(self.contentsScrollViewHeight)
        )
        
        //スクロールビューデリゲート
        self.buttonScrollView.delegate = self
        self.contentsScrollView.delegate = self
        
        //スクロールビューの定義
        self.initButtonScrollViewSettings()
        self.initContentsScrollViewSettings()
        
        //コンテナの初期位置
        self.containerPosition = ContainerDefinition.FirstContainer
        
        //各ScrollViewに要素を等間隔に配置
        for i in 0...(self.containerCount - 1){
            
            self.addButtonToButtonScrollView(i)
            self.addContainerViewToContentsScrollView(i)
        }
        
        //動くラベルの配置
        self.slidingLabel = UILabel()
        self.buttonScrollView.addSubview(self.slidingLabel)
        self.slidingLabel.frame = CGRectMake(
            CGFloat(0),
            CGFloat(self.slidingLabelPosY),
            CGFloat(DeviceSize.screenWidth() / 3),
            CGFloat(self.slidingLabelHeight)
        )
        self.slidingLabel.backgroundColor = UIColor.darkGrayColor()
        
    }
    
    //segueを呼び出したときに呼ばれるメソッド
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "fromChildController"{
            
            /**
             *
             * ■ このサンプルのポイント
             * self.parentViewController?.performSegueWithIdentifier("fromChildController", sender: resultDictionary)
             * (何をやっているの？)
             * このメソッドで渡されたsenderの値を遷移先のControllerへ引き渡しをする
             *
             */
            
            let dataList: AnyObject = sender as! [String : String]
            
            let resultController = segue.destinationViewController as! ResultController
            
            resultController.sendColor = dataList["color"] as! String
            resultController.sendLabel = dataList["name"] as! String
        }
    }
    
    //スクロールが発生した際に行われる処理
    //※ ボタンが押される or コンテナ表示部分をスクロールスクロールすると発生する
    func scrollViewDidScroll(scrollview: UIScrollView) {
        
        //コンテンツのスクロールのみ検知
        if scrollview.tag == ScrollViewDefinition.ContentsArea.returnValue() {
        
            //現在表示されているページ番号を判別する
            let pageWidth: CGFloat = self.contentsScrollView.frame.size.width
            let fractionalPage: Double = Double(self.contentsScrollView.contentOffset.x / pageWidth)
            let page: NSInteger = lround(fractionalPage)
            
            //動くラベルをスライドさせる
            self.moveFormUnderlabel(page)
            
            //ボタン配置用のスクロールビューもスライドさせる
            self.moveFormNowButtonContentsScrollView(page)
            
        }
        
    }

    //ボタンをタップした際に行われる処理
    func buttonTapped(button: UIButton){
        
        //押されたボタンのタグを取得
        let page: Int = button.tag
        
        //コンテンツを押されたボタンに応じて移動する
        self.moveFormNowDisplayContentsScrollView(page)
        
    }
    
    //ボタン押下でコンテナをスライドさせる
    func moveFormNowDisplayContentsScrollView(page: Int) {
        
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: {
            
            self.contentsScrollView.contentOffset = CGPointMake(
                CGFloat(Int(self.view.frame.size.width) * page),
                CGFloat(0.0)
            )
            
        }, completion: nil)
        
    }
    
    //ボタンのスクロールビューをスライドさせる
    func moveFormNowButtonContentsScrollView(page: Int) {

        if page > 0 && page < (self.containerCount - 1) {
        
            UIView.animateWithDuration(0.2, delay: 0, options: [], animations: {
            
                self.buttonScrollView.contentOffset = CGPointMake(
                    CGFloat(Int(self.view.frame.size.width) / 3 * (page - 1)),
                    CGFloat(0.0)
                )
            
            }, completion: nil)
        }
        
    }
    
    //動くラベルをスライドさせる
    func moveFormUnderlabel(page: Int) {
        
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: {
            
            self.slidingLabel.frame = CGRectMake(
                CGFloat(DeviceSize.screenWidth() / 3 * page),
                CGFloat(self.slidingLabelPosY),
                CGFloat(DeviceSize.screenWidth() / 3),
                CGFloat(self.slidingLabelHeight)
            )
            
        }, completion: nil)
    }
    
    //ボタンの初期配置を行う
    func addButtonToButtonScrollView(i: Int) {
        
        let buttonElement: UIButton! = UIButton()
        self.buttonScrollView.addSubview(buttonElement)
        
        let pX: CGFloat = CGFloat(DeviceSize.screenWidth() / 3 * i)
        let pY: CGFloat = CGFloat(0)
        let pW: CGFloat = CGFloat(DeviceSize.screenWidth() / 3)
        let pH: CGFloat = CGFloat(self.buttonScrollViewHeight)
        
        buttonElement.frame = CGRectMake(pX, pY, pW, pH)
        buttonElement.backgroundColor = UIColor.clearColor()
        buttonElement.setTitle(ButtonTextDefinition.getButtonLabel(i), forState: .Normal)
        buttonElement.titleLabel!.font = UIFont(name: "Bold", size: CGFloat(16))
        buttonElement.tag = i
        buttonElement.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
    }
    
    //コンテナの初期配置を行う
    func addContainerViewToContentsScrollView(i: Int) {
        
        let pX: CGFloat = CGFloat(DeviceSize.screenWidth() * i)
        let pY: CGFloat = CGFloat(0)
        let pW: CGFloat = CGFloat(DeviceSize.screenWidth())
        let pH: CGFloat = CGFloat(self.contentsScrollViewHeight)
        
        //Containerの配置をする
        if i == ContainerDefinition.FirstContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.firstContainer)
            self.firstContainer.frame = CGRectMake(pX, pY, pW, pH)
            
        } else if i == ContainerDefinition.SecondContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.secondContainer)
            self.secondContainer.frame = CGRectMake(pX, pY, pW, pH)
            
        } else if i == ContainerDefinition.ThirdContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.thirdContainer)
            self.thirdContainer.frame = CGRectMake(pX, pY, pW, pH)
            
        } else if i == ContainerDefinition.FourthContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.fourthContainer)
            self.fourthContainer.frame = CGRectMake(pX, pY, pW, pH)
            
        } else if i == ContainerDefinition.FifthContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.fifthContainer)
            self.fifthContainer.frame = CGRectMake(pX, pY, pW, pH)
            
        } else if i == ContainerDefinition.SixthContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.sixthContainer)
            self.sixthContainer.frame = CGRectMake(pX, pY, pW, pH)

        }
    }
    
    //ボタン配置用Scrollviewの初期セッティング
    func initButtonScrollViewSettings() {
        
        self.buttonScrollView.tag = ScrollViewDefinition.ButtonArea.returnValue()
        self.buttonScrollView.pagingEnabled = false
        self.buttonScrollView.scrollEnabled = true
        self.buttonScrollView.directionalLockEnabled = false
        self.buttonScrollView.showsHorizontalScrollIndicator = false
        self.buttonScrollView.showsVerticalScrollIndicator = false
        self.buttonScrollView.bounces = false
        self.buttonScrollView.scrollsToTop = false
        
        //コンテンツサイズの決定
        self.buttonScrollView.contentSize = CGSizeMake(
            CGFloat(DeviceSize.screenWidth() * self.containerCount / 3),
            CGFloat(self.buttonScrollViewHeight)
        )
    }

    //コンテンツ配置用Scrollviewの初期セッティング
    func initContentsScrollViewSettings() {
        
        self.contentsScrollView.tag = ScrollViewDefinition.ContentsArea.returnValue()
        self.contentsScrollView.pagingEnabled = true
        self.contentsScrollView.scrollEnabled = true
        self.contentsScrollView.directionalLockEnabled = false
        self.contentsScrollView.showsHorizontalScrollIndicator = true
        self.contentsScrollView.showsVerticalScrollIndicator = false
        self.contentsScrollView.bounces = false
        self.contentsScrollView.scrollsToTop = false
        
        //コンテンツサイズの決定
        self.calcContentsScrollViewSize()
        self.contentsScrollView.backgroundColor = UIColor.lightGrayColor()
        self.contentsScrollView.contentSize = CGSizeMake(
            CGFloat(DeviceSize.screenWidth() * self.containerCount),
            CGFloat(self.contentsScrollViewHeight)
        )
    }
    
    //初期位置・初期配置を決定する
    func calcContentsScrollViewSize() {
        
        //buttonScrollViewのY座標＆高さを元に位置計算を行っている
        self.contentsScrollViewPosY = (self.buttonScrollViewPosY + self.buttonScrollViewHeight)
        self.contentsScrollViewHeight = (DeviceSize.screenHeight() - self.contentsScrollViewPosY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

