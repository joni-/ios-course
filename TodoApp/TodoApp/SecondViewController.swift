//
//  SecondViewController.swift
//  TodoApp
//
//  Created by Joni Nevalainen on 21/01/17.
//  Copyright © 2017 Joni Nevalainen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var todoInput: UITextField!

    @IBAction func addButton(_ sender: Any) {
        if let todo = self.todoInput.text {
            if !todo.isEmpty {
                var todos = UserDefaults.standard.array(forKey: "todos") ?? []
                todos.append(todo)
                todoInput.text = "";
                UserDefaults.standard.set(todos, forKey: "todos")
                print(todos)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

