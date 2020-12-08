//
//  SeeViewController.swift
//  memop
//
//  Created by 徳永勇希 on 2020/08/08.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit


class SeeViewController: UIViewController {
    var dispmemo:[[String:String]] = []
    var indexNum = 0
    var screenShotImage = UIImage()
    @IBOutlet weak var displayTaitol: UITextField!
    
    @IBOutlet weak var displayContent: UITextView!
    
    @IBOutlet weak var displayDate: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        displayTaitol.text = dispmemo[indexNum]["title"]
        displayContent.text = dispmemo[indexNum]["content"]
        displayDate.text = dispmemo[indexNum]["date"]
        print(dispmemo)
    }
    
    @IBAction func newButton(_ sender: Any) {
        var newMemos = UserDefaults.standard.array(forKey: "memos") as? [[String:String]]
        //タイトル
        dispmemo[indexNum]["title"] = displayTaitol.text
        dispmemo[indexNum]["date"] = displayDate.text
        dispmemo[indexNum]["content"] = displayContent.text
        newMemos = dispmemo
        UserDefaults.standard.set(newMemos, forKey: "memos")
        //defaults.set(indexNum, forKey: "indexNum")
        
        navigationController?.popViewController(animated: true)
    }
    @IBAction func shareButton(_ sender: Any) {
        
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        displayContent.resignFirstResponder()
        
    }
    
}
