//
//  ViewController.swift
//  memop
//
//  Created by 徳永勇希 on 2020/08/08.
//  Copyright © 2020 yuuki. All rights reserved.
//

import UIKit
import ViewAnimator
class ViewController: UIViewController {
    var memo:[[String:String]]{
        get{
            return UserDefaults.standard.array(forKey: "memos") as? [[String:String]] ?? []
        }
        
        set{
            
            UserDefaults.standard.set(newValue, forKey: "memos")
            
        }
        
    }
    let cellSpacingHeight: CGFloat = 5
    @IBOutlet weak var memotableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellSetUp()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //var memos:[[String:String]] = []
        //memos = UserDefaults.standard.array(forKey: "newMemos") as? [[String:String]] ?? []
        memotableView.reloadData()
    }
    func cellSetUp(){
        
        memotableView.delegate = self
        memotableView.dataSource = self
        memotableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        memotableView.rowHeight = UITableView.automaticDimension
        
        memotableView.estimatedRowHeight = 70
        
        memotableView.separatorStyle = .none
        
        // 編集中のセル選択を許可.
        memotableView.allowsSelectionDuringEditing = true
    }
    
    /*
     編集ボタンが押された際に呼び出される
     
     override func setEditing(_ editing: Bool, animated: Bool) {
     super.setEditing(editing, animated: animated)
     
     // TableViewを編集可能にする
     memotableView.setEditing(editing, animated: true)
     
     
     }
     
     */
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    // 行間のスペースを実現するために、セクションを使用
    // 1セクション = 1行 にしてヘッダーで余白を表現している
    func numberOfSections(in tableView: UITableView) -> Int {
        return memo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        cell.taitollabel.text = memo[indexPath.section]["title"]
        cell.datelabel.text = memo[indexPath.section]["date"]
        
        cell.iconImage.image = UIImage(named: "love")
        
        cell.backgroundColor = .magenta
        cell.layer.cornerRadius = 25
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //インスタンス化かな
        let seeVC = self.storyboard?.instantiateViewController(withIdentifier: "next") as! SeeViewController
        
        seeVC.dispmemo = memo
        //タップした場所送る
        seeVC.indexNum = indexPath.section
        print(indexPath.section)
        self.navigationController?.pushViewController(seeVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12  // Cell間に設けたい余白の高さを指定
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear  // 背景色を透過させる
        return marginView
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    //スワイプしたセルを削除　　＊memoは作るものによって変わる
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //memo.remove(at: indexPath.section)
            //tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            self.memo.remove(at: indexPath.section)
            
            //セクションごと削除
            //セルを削除するとnilのcellを持つセクションになるため落ちるみたい
            let indexSet = NSMutableIndexSet()
            indexSet.add(indexPath.section)
            tableView.deleteSections(indexSet as IndexSet, with: UITableView.RowAnimation.automatic )
            
            
        }
        
        
    }
}

