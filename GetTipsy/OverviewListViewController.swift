//
//  OverviewListViewController.swift
//  GetTipsy
//
//  Created by Martin Malmgren on 2018-10-15.
//  Copyright © 2018 Martin Malmgren. All rights reserved.
//

import UIKit

class OverViewListCell : UITableViewCell {
    
    @IBOutlet weak var QuestionNumberLabel: UILabel!
    @IBOutlet weak var PlatsLabel: UILabel!
    @IBOutlet weak var AnswearedView: UIView!
    
    
    
    
}

class OverviewListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Row", for: indexPath) as! OverViewListCell
        cell.AnswearedView.layer.cornerRadius = 5
        cell.PlatsLabel.text = "Hörnan till vänster"
        cell.QuestionNumberLabel.text = "Fråga: " + String(indexPath.row + 1)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "OverViewToQuestion", sender: self)
    }
    @IBOutlet weak var Tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tableview.dataSource = self
        Tableview.delegate = self
        // Do any additional setup after loading the view.
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
