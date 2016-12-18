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
    
    //ボタンスクロール時の移動量
    var scrollButtonOffsetX: Int!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //初期値の計算を行う
        calcContentsScrollViewSize()
        
        //ボタン表示用ScrollViewの位置決定
        buttonScrollView.frame = CGRect(
            x: CGFloat(0),
            y: CGFloat(self.buttonScrollViewPosY),
            width: CGFloat(DeviceSize.screenWidth()),
            height: CGFloat(self.buttonScrollViewHeight)
        )
        
        //コンテンツ表示用ScrollViewの位置決定
        contentsScrollView.frame = CGRect(
            x: CGFloat(0),
            y: CGFloat(self.contentsScrollViewPosY),
            width: CGFloat(DeviceSize.screenWidth()),
            height: CGFloat(self.contentsScrollViewHeight)
        )
        
        //スクロールビューデリゲート
        buttonScrollView.delegate = self
        contentsScrollView.delegate = self
        
        //スクロールビューの定義
        initButtonScrollViewSettings()
        self.initContentsScrollViewSettings()
        
        //コンテナの初期位置
        containerPosition = ContainerDefinition.firstContainer
        
        //各ScrollViewに要素を等間隔に配置
        for i in 0...(containerCount - 1){
            
            self.addButtonToButtonScrollView(i)
            self.addContainerViewToContentsScrollView(i)
        }
        
        //動くラベルの配置
        slidingLabel = UILabel()
        buttonScrollView.addSubview(self.slidingLabel)
        slidingLabel.frame = CGRect(
            x: CGFloat(0),
            y: CGFloat(self.slidingLabelPosY),
            width: CGFloat(DeviceSize.screenWidth() / 3),
            height: CGFloat(self.slidingLabelHeight)
        )
        slidingLabel.backgroundColor = UIColor.darkGray
        
    }
    
    //segueを呼び出したときに呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "fromChildController"{
            
            /**
             * ■ このサンプルのポイント
             * 
             * 子供のコントローラーで遷移を行うボタンに下記の記述を施す 
             * (StoryBoardで任意のViewControllerにContainerを配置した場合、ContainerでEmbed Segueで繋がっているViewControllerは、配置されたViewControllerの子供のコントローラーとして認識される)
             * self.parentViewController?.performSegueWithIdentifier("fromChildController", sender: resultDictionary)
             *
             * → このメソッドで渡されたsenderの値を遷移先のControllerへ引き渡しをする
             */
            
            let dataList: AnyObject = sender as! [String : String] as AnyObject
            let resultController = segue.destination as! ResultController
            
            resultController.sendColor = dataList["color"] as! String
            resultController.sendLabel = dataList["name"] as! String
        }
    }
    
    //スクロールが発生した際に行われる処理
    /**
     * ■ このサンプルのポイント
     *
     * スクロールが発生した際に行われる処理
     * スクロールビューにtagプロパティを設定しコンテンツのスクロールのみを検知するようにする
     *
     *  → 場合は下記2パターンになる
     ※ Case1. ボタンが押される(ボタンエリアのスクロールでは作動しない)
     * Case2. コンテナ表示部分を直にスクロールすると
     */
    func scrollViewDidScroll(_ scrollview: UIScrollView) {
        
        //コンテンツのスクロールのみ検知
        if scrollview.tag == ScrollViewDefinition.contentsArea.returnValue() {
        
            //現在表示されているページ番号を判別する
            let pageWidth: CGFloat = self.contentsScrollView.frame.size.width
            let fractionalPage: Double = Double(self.contentsScrollView.contentOffset.x / pageWidth)
            let page: NSInteger = lround(fractionalPage)
            
            //動くラベルをスライドさせる
            moveFormUnderlabel(page)
            
            //ボタン配置用のスクロールビューもスライドさせる
            moveFormNowButtonContentsScrollView(page)
            
        }
        
    }

    //ボタンをタップした際に行われる処理
    func buttonTapped(_ button: UIButton){
        
        //押されたボタンのタグを取得
        let page: Int = button.tag
        
        //コンテンツを押されたボタンに応じて移動する
        self.moveFormNowDisplayContentsScrollView(page)
        
    }
    
    //ボタン押下でコンテナをスライドさせる
    func moveFormNowDisplayContentsScrollView(_ page: Int) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            
            self.contentsScrollView.contentOffset = CGPoint(
                x: CGFloat(Int(self.view.frame.size.width) * page),
                y: CGFloat(0.0)
            )
            
        }, completion: nil)
        
    }
    
    //ボタンのスクロールビューをスライドさせる
    func moveFormNowButtonContentsScrollView(_ page: Int) {

        //Case1. ボタンを内包しているスクロールビューの位置変更をする
        if page > 0 && page < (self.containerCount - 1) {
        
            scrollButtonOffsetX = Int(self.view.frame.size.width) / 3 * (page - 1)
        
        //Case2. 一番最初のpage番号のときの移動量
        } else if page == 0 {
            
            scrollButtonOffsetX = 0
        
        //Case3. 一番最後のpage番号のときの移動量
        } else if page == (self.containerCount - 1) {
            
            scrollButtonOffsetX = Int(self.view.frame.size.width)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            
            self.buttonScrollView.contentOffset = CGPoint(
                x: CGFloat(self.scrollButtonOffsetX),
                y: CGFloat(0.0)
            )
            
        }, completion: nil)
        
    }
    
    //動くラベルをスライドさせる
    func moveFormUnderlabel(_ page: Int) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            
            self.slidingLabel.frame = CGRect(
                x: CGFloat(DeviceSize.screenWidth() / 3 * page),
                y: CGFloat(self.slidingLabelPosY),
                width: CGFloat(DeviceSize.screenWidth() / 3),
                height: CGFloat(self.slidingLabelHeight)
            )
            
        }, completion: nil)
    }
    
    //ボタンの初期配置を行う
    func addButtonToButtonScrollView(_ i: Int) {
        
        let buttonElement: UIButton! = UIButton()
        buttonScrollView.addSubview(buttonElement)
        
        let pX: CGFloat = CGFloat(DeviceSize.screenWidth() / 3 * i)
        let pY: CGFloat = CGFloat(0)
        let pW: CGFloat = CGFloat(DeviceSize.screenWidth() / 3)
        let pH: CGFloat = CGFloat(self.buttonScrollViewHeight)
        
        buttonElement.frame = CGRect(x: pX, y: pY, width: pW, height: pH)
        buttonElement.backgroundColor = UIColor.clear
        buttonElement.setTitle(ButtonTextDefinition.getButtonLabel(i), for: UIControlState())
        buttonElement.titleLabel!.font = UIFont(name: "Bold", size: CGFloat(16))
        buttonElement.tag = i
        buttonElement.addTarget(self, action: #selector(ViewController.buttonTapped(_:)), for: .touchUpInside)
    }
    
    //コンテナの初期配置を行う
    func addContainerViewToContentsScrollView(_ i: Int) {
        
        let pX: CGFloat = CGFloat(DeviceSize.screenWidth() * i)
        let pY: CGFloat = CGFloat(0)
        let pW: CGFloat = CGFloat(DeviceSize.screenWidth())
        let pH: CGFloat = CGFloat(self.contentsScrollViewHeight)
        
        //Containerの配置をする
        if i == ContainerDefinition.firstContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.firstContainer)
            self.firstContainer.frame = CGRect(x: pX, y: pY, width: pW, height: pH)
            
        } else if i == ContainerDefinition.secondContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.secondContainer)
            self.secondContainer.frame = CGRect(x: pX, y: pY, width: pW, height: pH)
            
        } else if i == ContainerDefinition.thirdContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.thirdContainer)
            self.thirdContainer.frame = CGRect(x: pX, y: pY, width: pW, height: pH)
            
        } else if i == ContainerDefinition.fourthContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.fourthContainer)
            self.fourthContainer.frame = CGRect(x: pX, y: pY, width: pW, height: pH)
            
        } else if i == ContainerDefinition.fifthContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.fifthContainer)
            self.fifthContainer.frame = CGRect(x: pX, y: pY, width: pW, height: pH)
            
        } else if i == ContainerDefinition.sixthContainer.returnValue() {
            
            self.contentsScrollView.addSubview(self.sixthContainer)
            self.sixthContainer.frame = CGRect(x: pX, y: pY, width: pW, height: pH)

        }
    }
    
    //ボタン配置用Scrollviewの初期セッティング
    func initButtonScrollViewSettings() {
        
        buttonScrollView.tag = ScrollViewDefinition.buttonArea.returnValue()
        buttonScrollView.isPagingEnabled = false
        buttonScrollView.isScrollEnabled = true
        buttonScrollView.isDirectionalLockEnabled = false
        buttonScrollView.showsHorizontalScrollIndicator = false
        buttonScrollView.showsVerticalScrollIndicator = false
        buttonScrollView.bounces = false
        buttonScrollView.scrollsToTop = false
        
        //コンテンツサイズの決定
        buttonScrollView.contentSize = CGSize(
            width: CGFloat(DeviceSize.screenWidth() * containerCount / 3),
            height: CGFloat(buttonScrollViewHeight)
        )
    }

    //コンテンツ配置用Scrollviewの初期セッティング
    func initContentsScrollViewSettings() {
        
        contentsScrollView.tag = ScrollViewDefinition.contentsArea.returnValue()
        contentsScrollView.isPagingEnabled = true
        contentsScrollView.isScrollEnabled = true
        contentsScrollView.isDirectionalLockEnabled = false
        contentsScrollView.showsHorizontalScrollIndicator = true
        contentsScrollView.showsVerticalScrollIndicator = false
        contentsScrollView.bounces = false
        contentsScrollView.scrollsToTop = false
        
        //コンテンツサイズの決定
        calcContentsScrollViewSize()
        contentsScrollView.backgroundColor = UIColor.lightGray
        contentsScrollView.contentSize = CGSize(
            width: CGFloat(DeviceSize.screenWidth() * containerCount),
            height: CGFloat(contentsScrollViewHeight)
        )
    }
    
    //初期位置・初期配置を決定する
    func calcContentsScrollViewSize() {
        
        //buttonScrollViewのY座標＆高さを元に位置計算を行っている
        contentsScrollViewPosY = (buttonScrollViewPosY + buttonScrollViewHeight)
        contentsScrollViewHeight = (DeviceSize.screenHeight() - contentsScrollViewPosY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

