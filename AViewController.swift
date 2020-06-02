//
//  AViewController.swift
//  ImobiliareApp2
//
//  Created by user169246 on 5/23/20.
//  Copyright © 2020 Costache_Adriana. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
class AViewController: UIViewController{

    
    @IBOutlet weak var AddButton: UIBarButtonItem!
    @IBOutlet weak var TrashButton: UIBarButtonItem!
    
    @IBOutlet weak var NumRooms: UITextField!
    @IBOutlet weak var ScopeTextFild: UITextField!
    
    @IBOutlet weak var TypeOfProperty: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    
    
   
    @IBOutlet weak var SurfaceTextField: UITextField!
    
    @IBOutlet weak var YearOfConstructionTextField: UITextField!
    
    @IBOutlet weak var PriceTextField: UITextField!
    
    @IBOutlet weak var TescriptionFextView: UITextView!
    
    @IBOutlet weak var ContactTextField: UITextField!
    
    @IBOutlet weak var LatitudeTextField: UITextField!
    
    @IBOutlet weak var LongitudeTextField: UITextField!
    
    @IBOutlet weak var MyImageView: UIImageView!

    
    
    let imagePicker = UIImagePickerController()
    let videPicke = UIVideoEditorController()
    var ref = DatabaseReference()
    var videoURL: NSURL?
    var urlOfVideo = NSURL()
    var CopyPath = String()
    var videoPath = String()
    var ref2 = Database.database().reference()
    @IBAction func importVideo(_ sender: AnyObject)
    {//let video = UIImagePickerController()
//        let video = UIPickerVie
    }
    
    // imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]){
        
       // let mediaType =  picker.mediaTypes
          
        //let type:AnyObject = mediaType as AnyObject
          ///  type is String
            //let stringType = type as! String
            //if stringType == "public.movie" as! String {
                //urlOfVideo = (info[UIImagePickerController.InfoKey.mediaURL.rawValue] as? NSURL)!
               // print(urlOfVideo)
               // let videoName = urlOfVideo.path!}
        
    //}
              

       
    @IBAction func AddPost(_ sender: AnyObject) {
    
        self.saveFireData()
        ref2.child("PropertyType").childByAutoId().setValue(TypeOfProperty.text)
        ref2.child("Scope").childByAutoId().setValue(ScopeTextFild.text)
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(sender: UIImage) {
        imagePicker.sourceType = (.photoLibrary)
        imagePicker.delegate = self
        imagePicker.mediaTypes = ["public.image", "public.movie"]

        present(imagePicker, animated: true, completion: nil)
       }
    
    
      // @IBAction func TrashPost(_ sender: Any) {
               
  //  presentingViewController;?.dismiss(animated: true, completion: nil)
      //
      // }
    
    
       @objc func openGallery(tapGesture: UITapGestureRecognizer)
       {
           self.setupImagePicker()
        
       }
    
    func saveFireData(){
        self.uploadImage(_image: self.MyImageView.image!){ url in
            self.saveImage(name: "m", imageURL: url!){ succes in
                if succes !=  nil{
                    print("succes")
                }
                
            }
            
        }
    }
           func setImagePicker(){
           //if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
    }

            //imagePicker.present(imagePicker, animated: true, completion: nil)}}
    
   override func viewDidLoad() {
    
    super.viewDidLoad()
    ref = Database.database().reference().child("Posts")
    let tapGesture = UITapGestureRecognizer()
    tapGesture.addTarget(self, action: #selector(AViewController.openGallery(tapGesture:)))
        MyImageView.isUserInteractionEnabled = true;
        MyImageView.addGestureRecognizer(tapGesture)
    
    //let tapG = UITapGestureRecognizer()
    //apG.addTarget(self, action:#selector(AViewController.openGallery(tapGesture:)))
    //VideoImg.isUserInteractionEnabled = true;
   // VideoImg.addGestureRecognizer(tapG)
       
      
    }
}

extension AViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func setupImagePicker(){
        //if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image", "public.movie"]

            //present(imagePicker, animated: true, completion: nil)
            imagePicker.delegate = self
            imagePicker.isEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        }
    
    //pt afisare
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        MyImageView.image = image
       self.dismiss(animated: true, completion: nil)
            }
    
    
    func VideoimagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]){
           
          let mediaType =  picker.mediaTypes
             
           let type:AnyObject = mediaType as AnyObject
              type is String
               let stringType = type as! String
               if stringType == "public.movie" as! String {
                   urlOfVideo = (info[UIImagePickerController.InfoKey.mediaURL.rawValue] as? NSURL)!
                print(urlOfVideo)
                  let videoName = urlOfVideo.path!}
           
       }

}

extension AViewController{
func uploadImage(_image:UIImage, completion: @escaping((_ url: URL?) -> () )){
    
    let storageRef = Storage.storage().reference().child("myimage.pgn")
    let imgData = MyImageView.image?.pngData()
    let metaData = StorageMetadata()
    metaData.contentType = "image/pgn"
    storageRef.putData(imgData!, metadata:  metaData){
        (metaData, error)in
        if error == nil{
            print("succes")
            storageRef.downloadURL(completion: { (url, error) in
                completion(url!)
            })
        } else {
            print("error in save image")
            completion(nil)
        }
    }
   }
    
    
    func saveImage(name: String, imageURL :URL, completion: @escaping((_ url: URL?) -> () )){
          let key = ref.childByAutoId().key
        let postare = ["id" : key, "scope" : ScopeTextFild.text!,  "city" : CityTextField.text!,
                       "type_of_ propery": TypeOfProperty.text!, "number_of_rooms": NumRooms.text!,
          "surface": SurfaceTextField.text!, "year_of_construction": YearOfConstructionTextField.text!,
          "price": PriceTextField.text!, "description": TescriptionFextView.text!,
          //"latitude": LatitudeTextField.text!, "longitude": LongitudeTextField.text!,
            "contact":ContactTextField.text!,
            "latitude:" : LatitudeTextField.text!,
            "longitude" : LongitudeTextField.text!,
          "imageURL": imageURL.absoluteString] as? [String: Any]
          ref.child(key!).setValue(postare)
     
     }
    
   
      }
    
    
    
      
        
        
     
   



        
        

    


