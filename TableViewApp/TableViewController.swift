//
//  TableViewController.swift
//  TableViewApp
//
//  Created by 鳥山彰仁 on 2022/10/16.
//

import UIKit

class TableViewController: UITableViewController {
    
    //編集ボタンプロパティ
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    //編集ボタンメソッド
    @IBAction func editButtonClicked(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
        if tableView.isEditing {
            editButton.title = "終了"
        } else {
            editButton.title = "編集"
        }
    }
    
    
    //AddListViewControllerで保存したタスクの配列
    var taskArray: [String] = []
    // 画面内に表示する名前を入れています。
    //       var names: [String] = [
    //           "阿部",
    //           "石田",
    //           "上田",
    //           "遠藤",
    //           "及川",
    //           "梶原",
    //           "菊池",
    //           "工藤",
    //       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //同じ処理を何度も繰り返し行えるメソッド
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userDefaults = UserDefaults.standard
        
        //"add"というキーで保存された値がなにかある -> 値をtaskArrayへ
        if userDefaults.object(forKey: "add") != nil {
            taskArray = userDefaults.object(forKey: "add") as! [String]
        }
        //tableViewの見た目を更新
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    // セクションの数(セルをグループ化した塊)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //TableViewに表示させるセルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    //UITableViewに表示させるセルを返します
    //dequeueReusableCellのwithIdentifierはセルのIdentifierと同じもの
    //indexPath.rowは0からセルの数までの連番です
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        //何行目にタスクが実行されるか
        cell.textLabel?.text = taskArray[indexPath.row]
        return cell
    }
    
    
    //Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            taskArray.remove(at: indexPath.row)
            UserDefaults.standard.set(taskArray, forKey: "add" )
            tableView.deleteRows(at: [indexPath], with: .fade)
            //        } else if editingStyle == .insert {
            //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
    
    
    // Override to support rearranging the table view.
    //     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    //
    //     }
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let selectedItem = taskArray[sourceIndexPath.row]
        taskArray.remove(at: sourceIndexPath.row)
        taskArray.insert(selectedItem, at: destinationIndexPath.row)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}
