//
//  LoginViewController.swift
//  ImobiliareApp2
//
//  Created by user169246 on 5/20/20.
//  Copyright © 2020 Costache_Adriana. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import AVKit


class LoginViewController: UIViewController {

    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    
    @IBOutlet weak var emailFieldText: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var newAccountButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var videoPlayer: AVPlayer?
       
    var videoPlayerLayer: AVPlayerLayer?
       
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpElements()
        
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        setUpVideo()
    }
      func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        Utilities.styleLabel(EmailLabel)
        Utilities.styleLabel(PasswordLabel)
        // Style the elements
        Utilities.styleTextField(emailFieldText)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleHollowButton(newAccountButton)
         }
    
    func setUpVideo() {
        
        // Get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "home", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        
        // Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        // Create the video player item
        let item = AVPlayerItem(url: url)
        
        // Create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        // Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*2, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height/2)
        videoPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height/2)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.3)

    }
    @IBAction func loginTapped(_ sender: Any) {
            // TODO: Validate Text Fields
        
        // Create cleaned versions of the text field
        let email = emailFieldText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                
               let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                
                //let hometableViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.hometableViewController) as? HomeTableViewController
                //self.view.window?.rootViewController = hometableViewController
                //self.view.window?.makeKeyAndVisible()
            }
        }
        
       
        
        

    }
}
