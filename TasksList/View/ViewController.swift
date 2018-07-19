//
//  ViewController.swift
//  TasksList
//
//  Created by Nazar Kostiv on 7/17/18.
//  Copyright © 2018 Nazar Kostiv. All rights reserved.
//

import UIKit
import RealmSwift



class ViewController: UITableViewController {

  let realm = try! Realm()
  var items: Results<TasksList>! 


  @IBAction func pushAddItem(_ sender: Any) {
    addAlertForNewItem(title: "new taks", message: "write some text", placeholder: "new taks", titleForSaveAction: "save", styleForSave: .default, titleCancelingAction: "cansel", styleCancelingAction: .destructive)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    items = realm.objects(TasksList.self)
    NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
  }

  @objc func loadList(notification: NSNotification){
    self.tableView.reloadData()
  }


  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let item = items[indexPath.row]
    cell.textLabel?.text = item.task
    return cell
  }

  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

    let editingRow = items[indexPath.row]

    let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _,_ in
      try! self.realm.write {
        self.realm.delete(editingRow)
        tableView.reloadData()
      }
    }
    return [deleteAction]
  }


  var selectedData: String?

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = items[indexPath.row]
    selectedData = item.task
    self.performSegue(withIdentifier: "goToDetail", sender: self)
    if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
      tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
    } else {
      tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToDetail" {
      (segue.destination as! DetailViewController).textData = selectedData
    }
  }
}



















