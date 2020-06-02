//
//  RegisterViewController.swift
//  ImobiliareApp2
//
//  Created by user169246 on 5/20/20.
//  Copyright © 2020 Costache_Adriana. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import AVKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var SingInButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var IhaveanaccountButton: UIButton!
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
    
        // Style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(SingInButton)
        Utilities.styleFilledButton(IhaveanaccountButton)
    }
    
    
       
         func setUpVideo() {
         
         // Get the path to the resource in the bundle
         let bundlePath = Bundle.main.path(forResource: "house", ofType: "mp4")
         
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
         videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
         
         //videoPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
         view.layer.insertSublayer(videoPlayerLayer!, at: 0)
         
         // Add it to the view and play it
            videoPlayer?.playImmediately(atRate: 0.3)}
    
     // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
              }
        return nil
                 }
    
    
     func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
                                        }
    
    
      func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
            }
    
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
          // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
            
                }
        }
     
        
        }
    }

