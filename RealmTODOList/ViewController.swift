//
//  ViewController.swift
//  RealmTODOList
//
//  Created by Sudhir Shrestha on 29/12/17.
//  Copyright © 2017 Robert Shrestha. All rights reserved.
//

import UIKit
import RealmSwift

var toDos: Results<ToDo>!
var realm = try! Realm()

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        self.reload()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        toDos = realm.objects(ToDo.self).sorted(byKeyPath: "ToDoText", ascending: true)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.reload()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func reload(){
        self.tableView.reloadData()
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let todo = toDos[indexPath.row]
        cell.textLabel?.text = todo.ToDoText
        cell.detailTextLabel?.text = todo.isDone ? "Done" : "Not Done"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InsertViewController") as! InsertViewController
        vc.inComingtoDo = toDos[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            do{
            try realm.write {
                realm.delete(toDos[indexPath.row])
            }
            reload()
            }catch(let error){
                print(error)
                
            }
        }
    }
}
class ToDo:Object{
    dynamic var ToDoText = ""
    dynamic var isDone = false
    
}

