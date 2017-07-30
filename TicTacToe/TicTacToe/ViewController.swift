//
//  ViewController.swift
//  TicTacToe
//
//  Created by Joni Nevalainen on 05/02/17.
//  Copyright © 2017 Joni Nevalainen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static let CROSS = "X"
    static let NOUGHT = "0"
    static let TIE = "TIE"

    @IBOutlet weak var resultsHolder: UIView!

    @IBOutlet weak var resultLabel: UILabel!

    @IBOutlet weak var restartButtonOutlet: UIButton!

    @IBAction func restartAction(_ sender: Any) {
        self.resetState()
        self.createBoard()
    }

    @IBOutlet var container: UIView!

    var currentPlayer: String = ViewController.CROSS
    var board: [String] = Array(repeating: "", count: 9)
    var buttons: [UIButton] = []
    var gameEnded: Bool = false

    func resetState() {
        self.board = Array(repeating: "", count: 9)
        self.buttons = []
        self.gameEnded = false

        self.resultsHolder.layer.isHidden = true
    }

    func createBoard() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        let btnWidth = Int(screenWidth / 3)
        let btnHeight = Int(screenHeight / 3)
        let margin = 5

        for i in 0 ..< 9 {
            let column = i % 3
            let row = i / 3
            let x = column * btnWidth + (margin * column);
            let y = row * btnHeight + (margin * row);

            let btn: UIButton = UIButton(frame: CGRect.init(x: x, y: y, width: btnWidth, height: btnHeight))
            btn.backgroundColor = UIColor.red
            btn.setTitle(String(i), for: UIControlState.normal)
            btn.addTarget(self, action: #selector(btnClicked), for: UIControlEvents.touchUpInside)
            btn.tag = i
            buttons.append(btn)

            self.container.addSubview(btn);
        }

        self.redrawBoard()
    }

    func btnClicked(sender: UIButton) {
        if (gameEnded || !board[sender.tag].isEmpty) {
            return
        }

        board[sender.tag] = currentPlayer
        self.redrawBoard()

        let winner = self.getWinner()

        if (!winner.isEmpty) {
            self.gameEnded = true
            let result = winner == ViewController.TIE
                ? "Game tied"
                : winner + " won!"
            self.announceResult(result: result)
            return
        }

        currentPlayer = currentPlayer == ViewController.CROSS
            ? ViewController.NOUGHT
            : ViewController.CROSS
    }

    func getWinner() -> String {
        for row in 0 ..< 3 {
            let c1 = board[row * 3]
            let c2 = board[row * 3 + 1]
            let c3 = board[row * 3 + 2]

            if (c1 == c2 && c2 == c3 && !c1.isEmpty && !c2.isEmpty) {
                return c1
            }
        }

        for col in 0 ..< 3 {
            let c1 = board[col]
            let c2 = board[col + 3]
            let c3 = board[col + 6]

            if (c1 == c2 && c2 == c3 && !c1.isEmpty && !c2.isEmpty) {
                return c1
            }
        }

        let dlr1 = board[0]
        let dlr2 = board[4]
        let dlr3 = board[8]

        if (dlr1 == dlr2 && dlr2 == dlr3 && !dlr1.isEmpty && !dlr2.isEmpty) {
            return dlr1
        }

        let drl1 = board[2]
        let drl2 = board[4]
        let drl3 = board[6]

        if (drl1 == drl2 && drl2 == drl3 && !drl1.isEmpty && !drl2.isEmpty) {
            return drl1
        }

        return self.boardFull() ? ViewController.TIE : ""
    }

    func boardFull() -> Bool {
        for i in 0 ..< 9 {
            if (self.board[i].isEmpty) {
                return false
            }
        }

        return true
    }

    func announceResult(result: String) -> Void {
        self.resultsHolder.isHidden = false
        self.restartButtonOutlet.isUserInteractionEnabled = true

        for button in buttons {
            button.isUserInteractionEnabled = false
        }

        self.resultsHolder.alpha = 0.1

        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: UIViewAnimationOptions.transitionFlipFromRight,
            animations: {
                self.resultsHolder.alpha = 1
            },
            completion: nil
        )

        self.resultLabel.text = result
    }



    func redrawBoard() -> Void {
        for btn in self.buttons {
            let i = btn.tag
            btn.setTitle(board[i], for: UIControlState.normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.resultsHolder.isHidden = true;
        self.resultsHolder.layer.zPosition = 1
        self.createBoard();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

