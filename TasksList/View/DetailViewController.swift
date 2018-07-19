//
//  DetailViewController.swift
//  TasksList
//
//  Created by Nazar Kostiv on 7/17/18.
//  Copyright © 2018 Nazar Kostiv. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var label: UILabel!

  var textData: String?

    override func viewDidLoad() {
        super.viewDidLoad()
      label.text = textData
    }
}









