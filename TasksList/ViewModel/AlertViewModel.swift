//
//  AlertViewModel.swift
//  TasksList
//
//  Created by Nazar Kostiv on 7/19/18.
//  Copyright © 2018 Nazar Kostiv. All rights reserved.
//

import Foundation
import UIKit


func addAlertForNewItem(title: String, message: String, placeholder: String,titleForSaveAction: String, styleForSave: UIAlertActionStyle, titleCancelingAction: String, styleCancelingAction: UIAlertActionStyle) {

  let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
  var rootViewController = UIApplication.shared.keyWindow?.rootViewController
  if let navigationController = rootViewController as? UINavigationController {
    rootViewController = navigationController.viewControllers.first
  }
  if let tabBarController = rootViewController as? UITabBarController {
    rootViewController = tabBarController.selectedViewController
  }
  var alertTextField: UITextField!
  alert.addTextField { textField in
    alertTextField = textField
    textField.placeholder = placeholder
  }


  let saveAction = UIAlertAction(title: titleForSaveAction, style: styleForSave) { action in

    guard let text = alertTextField.text , !text.isEmpty else { return }

      let task = TasksList()
      task.task = text

//    try! self.realm.write {
//      self.realm.add(task)
//    }

   // self.tableView.reloadData()
  }

  let cancelAction = UIAlertAction(title: titleCancelingAction, style: styleCancelingAction, handler: nil)

  alert.addAction(saveAction)
  alert.addAction(cancelAction)

  rootViewController?.present(alert, animated: true, completion: nil)
}


