//
//  ConfigsViewController.swift
//  ParaD_RemoteIII
//
//  Created by David Para on 3/1/17.
//  Copyright © 2017 David Para. All rights reserved.
//

import UIKit

class ConfigsViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var favoritesSegment: UISegmentedControl!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelChangeSegment: UISegmentedControl!
    
    @IBAction func channelChangeSelectPressed(_ sender: UISegmentedControl) {
        let upOrDown = sender.selectedSegmentIndex
        switch upOrDown {
        case 1:
            channelUp()
        case 0:
            channelDown()
        default:
            break
            
        }
        self.channelChangeSegment.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    @IBAction func backgroundTouched(_ sender: UIControl) {
        textField.resignFirstResponder()
    }
    
    @IBAction func editEnded(_ sender: UITextField) {
        sender.resignFirstResponder();
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        if textField.text == "" ||
            (textField.text?.characters.count)! > 4 {
            invalidTextAlert()
            return
        }
        let name = textField.text?.uppercased()
        let number = channelLabel.text
        favoriteChannels[favoritesSegment.selectedSegmentIndex].setChannelName(to: name!)
        favoriteChannels[favoritesSegment.selectedSegmentIndex].setChannelNumber(to: number!)
        clearSettings()
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        clearSettings()
    }
    
    func invalidTextAlert() {
        let message = "Please enter a valid label for your favorite channel setting. It cannot be blank and it cannot contain more than 4 characters"
        let title = "Channel Label"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: . alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Gets current channel text, increases the number and prints to the channel label
    func channelUp () {
        var currentChannel = Int(self.channelLabel.text!)
        if currentChannel == 99 {
            currentChannel = 01
        } else {
            currentChannel! += 1
        }
        let channelUp = String(format: "%02d", currentChannel!)
        channelLabel.text = channelUp
    }

    // Gets current channel text, decreases the number and prints to the channel label

    func channelDown() {
        var currentChannel = Int(self.channelLabel.text!)
        if currentChannel == 01 {
            currentChannel = 99
        } else {
            currentChannel! -= 1
        }
        let channelDown = String(format: "%02d", currentChannel!)
        channelLabel.text = channelDown
    }
    
    func clearSettings() {
        textField.text = ""
        self.favoritesSegment.selectedSegmentIndex = UISegmentedControlNoSegment
        channelLabel.text = "01"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
