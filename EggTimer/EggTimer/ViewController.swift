//
//  ViewController.swift
//  EggTimer
//
//  Created by Joni Nevalainen on 10/01/17.
//  Copyright © 2017 Joni Nevalainen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = 210
    var clock = Timer()

    @IBOutlet weak var timerLabel: UILabel!

    @IBAction func decreaseButton(_ sender: Any) {
        timer -= 10
        updateTimerLabel()
    }

    @IBAction func increaseButton(_ sender: Any) {
        timer += 10
        updateTimerLabel()
    }

    @IBAction func resetButton(_ sender: Any) {
        timer = 210
        updateTimerLabel()
    }

    @IBAction func pauseButton(_ sender: Any) {
        clock.invalidate()
    }

    @IBAction func startButton(_ sender: Any) {
        clock = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(ViewController.updateTimer),
            userInfo: nil,
            repeats: true
        )
    }

    func updateTimer() {
        timer -= 1
        updateTimerLabel()

        if timer <= 0 {
            clock.invalidate()
        }
    }

    func updateTimerLabel() {
        timerLabel.text = String(timer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        updateTimerLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

