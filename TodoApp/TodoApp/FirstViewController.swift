//
//  FirstViewController.swift
//  TodoApp
//
//  Created by Joni Nevalainen on 21/01/17.
//  Copyright © 2017 Joni Nevalainen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var todosList: UITableView!

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let todos = UserDefaults.standard.array(forKey: "todos") ?? []
        return todos.count;
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todos = UserDefaults.standard.array(forKey: "todos") ?? []
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = String(describing: todos[indexPath.row])
        return cell
    }

    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var todos = UserDefaults.standard.array(forKey: "todos") ?? []
        todos.remove(at: indexPath.row)
        UserDefaults.standard.set(todos, forKey: "todos")
        self.todosList.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.todosList.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

