//
//  InsertViewController.swift
//  RealmTODOList
//
//  Created by Sudhir Shrestha on 29/12/17.
//  Copyright © 2017 Robert Shrestha. All rights reserved.
//

import UIKit
import RealmSwift

class InsertViewController: UIViewController {
    let realm = try! Realm()
    
    var inComingtoDo : ToDo? = nil
    
    
    @IBOutlet weak var txtField: UITextField!

    @IBOutlet weak var switchBtn: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let goodToDo = inComingtoDo{
            txtField.text = goodToDo.ToDoText
            switchBtn.isOn = goodToDo.isDone
        }else{
            print("Error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        if let goodToDo = inComingtoDo{
            do{
                try realm.write {
                    goodToDo.ToDoText = txtField.text!
                    goodToDo.isDone = switchBtn.isOn
                }
            }catch(let error){
                print(error)
            }
           self.navigationController?.popViewController(animated: true) 
        }else{
            let toDO = ToDo()
            toDO.ToDoText = self.txtField.text!
            toDO.isDone = self.switchBtn.isOn
            do{
                try realm.write {
                    realm.add(toDO)
                }
            }catch(let error){
                print(error)
            }
            self.navigationController?.popViewController(animated: true)
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
