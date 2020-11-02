//
//  ReserveViewController.swift
//  memop
//
//  Created by 徳永勇希 on 2020/08/08.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit

import Lottie

class ReserveViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet weak var taitolText: UITextField!
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var saveB: UIButton!
    
    @IBOutlet weak var animationDisp: UIView!
    var timer:Timer = Timer()
    
    var resString = ""
    var conString = ""
    var userDfTaitol = ""
    
    var screenShotImage = UIImage()
    
    //AnimationViewを宣言
    var animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        taitolText.delegate = self
        dateText.delegate = self
        contentText.delegate = self
        
    }

    func addAnimationView() {
        animationView = AnimationView(name: "21267-sucsses-button")
        animationView.frame = CGRect(x: animationDisp.bounds.minX, y: animationDisp.bounds.minY, width: animationDisp.frame.width, height: animationDisp.frame.height)
        animationDisp.addSubview(animationView)
        animationView.play()
    }
    
    @IBAction func reserveButton(_ sender: Any) {
        guard let taitol = taitolText.text,
            let content = contentText.text,let date = dateText.text else{
                return
        }
        let defaults = UserDefaults.standard
        
        // let memos = ["title":taitol,"content":content]
        
        //defaults.set(memos, forKey: "memos")
        //前の保存してあるものが入れ変わらないように、前のデータを一回保存する。
        var saveData = defaults.array(forKey: "memos") as? [[String:String]] ?? []
        let memos = ["title":taitol,"content":content,"date":date]
        saveData.append(memos)
        
        defaults.set(saveData, forKey: "memos")
        addAnimationView()
        
        timer = Timer.scheduledTimer(timeInterval: 3.0,
                                     target: self,
                                     selector: #selector(self.timerCounter),
                                     userInfo: nil,
                                     repeats: false)
        
        
    }
    @objc func timerCounter() {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func shareButton(_ sender: Any) {
        takeScreenShot()
        
        
        //アクティビティービューに乗っけて、シェアする
        let items = [screenShotImage] as [Any]
        
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
        
    }
    
    func takeScreenShot(){
        //スクリーンショットの幅と高さを決める。これしかないくらいの書き方で、func takeScreenShot()に書いてある全体のコードで、スクリーンショットがとれるよ、と思っていた方が、難しいこと考えずにできる！
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height/1.3)
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        //Viewに書き出す
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    @objc func changeView() {
        navigationController?.popViewController(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        contentText.endEditing(true)
        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
