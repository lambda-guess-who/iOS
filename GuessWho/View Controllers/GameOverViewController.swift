//
//  GameOverViewController.swift
//  GuessWho
//
//  Created by Steven Leyva on 7/31/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var catagoryLabel: UILabel!
    @IBOutlet weak var funnyNoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func playAgainTapped(_ sender: Any) {
    }

    @IBAction func sharedButtonTapped(_ sender: Any) {
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
