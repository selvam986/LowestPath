//
//  ViewController.swift
//  LowestPath
//
//  Created by Srinivasan, Selvam on 1/10/17.
//  Copyright © 2017 Srinivasan, Selvam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var matrixAlgorithm = Matrix()
    @IBOutlet weak var rowTextbox: UITextField!
    @IBOutlet weak var lblLowestPath: UILabel!
    @IBOutlet weak var lblLowestTotal: UILabel!
    @IBOutlet weak var lblRowTraversing: UILabel!
    @IBOutlet weak var lblErrorMsg: UILabel!
    @IBOutlet weak var txtRowView: UITextView!
    var rows: [[Any]] = []
    
    @IBAction func onClickingClear(_ sender: Any) {
        rows.removeAll()
        lblErrorMsg.text = "Successfully cleared!"
        lblErrorMsg.textColor = UIColor.green
        lblLowestPath.text = ""
        lblLowestTotal.text = ""
        lblRowTraversing.text = ""
        rowTextbox.text = ""
        txtRowView.text = ""
    }
    @IBAction func onClickingAddRow(_ sender: Any) {
        lblErrorMsg.text = ""
        if rowTextbox.text != "" {
            if matrixAlgorithm.verifyEachRows(input: addingRow(string: rowTextbox.text!)) {
                rows.append(addingRow(string: rowTextbox.text!))
                txtRowView.text = String(describing: rows)
                lblErrorMsg.text = "Successfully Added!"
                lblErrorMsg.textColor = UIColor.green
                rowTextbox.text = ""
            }
            else {
                lblErrorMsg.text = "Please enter valid row to add!"
                lblErrorMsg.textColor = UIColor.red
                rowTextbox.text = ""
            }
        }
        else{
            lblErrorMsg.text = "Please enter row to add!"
            lblErrorMsg.textColor = UIColor.red
        }
        lblLowestPath.text = ""
        lblLowestTotal.text = ""
        lblRowTraversing.text = ""
    }
    
    func addingRow(string: String) -> [Any] {
        let retString = string.components(separatedBy: ",")
        return retString
    }
    
    @IBAction func onClickingProcessMatrix(_ sender: Any) {
        if rows.count == 0 {
            lblErrorMsg.text = "Please enter some row to process!"
            lblErrorMsg.textColor = UIColor.red
        }
        else {
            let matrix = matrixAlgorithm.processInputColumns(rows: rows)
            lblLowestPath.text = (matrix.2 != nil ? "\(matrix.2!)" : "nil")
            lblLowestTotal.text = (matrix.1 != nil ? "\(matrix.1!)" : "nil")
            lblRowTraversing.text = (matrix.0 != nil ? "\(matrix.0!)" : "nil")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        txtRowView.isEditable = false
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

