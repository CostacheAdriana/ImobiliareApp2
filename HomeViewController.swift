
import UIKit
import FirebaseDatabase
import Kingfisher



class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{
    
    @IBOutlet weak var searchBar: UISearchBar!
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else{return}
        if searchText == "" {
            
        }else{
            
        }
    }
    
    
    var refPosts = DatabaseReference()
    var ref = DatabaseReference()
    var databaseHandle = DatabaseHandle()
    
   // var postData = [String]()
       
  var searchAnunturi = [String]()
    var searching = false
    @IBOutlet weak var tableView: UITableView!
   
    var postsList = [PostModel]()
    
       public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{ return searchAnunturi.count }
        else{
            return postsList.count}
      
       }
       
       
        
       public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
           let post : PostModel
           post = postsList[indexPath.row]
       
           cell.postModel = postsList[indexPath.row]
        if searching
           {
            cell.ScopeLabel?.text =  searchAnunturi[indexPath.row]
            
        }else { cell.postModel = postsList[indexPath.row]}
       // let searching {
           // cell.postsModel = searchAnunturi[indexPath.row]
       // }
           //var  imageList = [post.imageURL]
           //post = postsList[indexPath.ro
    
    
        return cell
      }

    
    /*@IBAction func ButtonTapped(_ sender: Any) {
        let descriptionViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.descriptionViewController) as? DescriptionViewController
               let post : PostModel
        
           post = postsList[indexPath.row]
           var  imageList = [post.imageURL]
          //  way?.DetailImage.image =  (imageList[indexPath.row])
            let url = URL(string: (post.imageURL)!)
            if let url = url as? URL{
                KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) {(image,error, cache, imageURL) in
                    ///self..image = image
                    //self.PostImage.kf.indicatorType = .activity
                    descriptionViewController?.DetailImage.image = image
                    descriptionViewController?.DetailImage.kf.indicatorType = .activity
                    self.navigationController?.pushViewController(descriptionViewController ??,UIViewController, animated:true)
        
                }

        self.view.window?.rootViewController = descriptionViewController
        self.view.window?.makeKeyAndVisible()
        }
        }
    */
    var scopeData = [String]()
    var searchPosts = [String]()
        
        
        override func viewDidLoad() {
      
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        refPosts = Database.database().reference().child("Posts")
        //set de firebase reference
        //ref = Database.database().reference()
        
        //Retrive the posts and listen for changes
       // databaseHandle = ref.child("Posts").observe(.childAdded, with: {(snapshot) in
            
            //code to execute when a child is added under posts
            //take the value from the snaphot and added it to postData array
            //let post = snapshot.value as? String
            //if let actualPost = post {
            //self.postData.append(actualPost)
            //self.tableView.reloadData()}
        //})
        
        databaseHandle =  ref.child("Scope").observe(.childAdded, with: {(snapshot) in
            let scope = snapshot.value as? String
            if let actpost = scope{
                
            self.scopeData.append(actpost)}
            self.tableView.reloadData()
        })
        
      
        refPosts.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
               self.postsList.removeAll()
                
               for posts in snapshot.children.allObjects as! [ DataSnapshot]{
                    let postObject = posts.value as? [String: AnyObject]
                    
                    let postId = postObject?["id"]
                    let scopePost = postObject?["scope"]
                    let cityPost = postObject?["city"]
                    let type_of_propertyPost = postObject?["type_of_property"]
                    let number_of_roomsPost = postObject?["number_of_rooms"]
                    let surfacePost = postObject?["surface"]
                    let year_of_constructionPost = postObject?["year_of_construction"]
                    let pricePost = postObject?["price"]
                    let descriptionPost = postObject?["description"]
                    let contactPost = postObject?["contact"]
                    let imagePost = postObject?["imageURL"]
                let post = PostModel(id: postId as! String?,
                                     scope: scopePost as! String?,
                                     city: cityPost as! String?,
                                     type_of_property: type_of_propertyPost as! String?,
                                     number_of_rooms : number_of_roomsPost as! String?,
                                     surface : surfacePost as! String?,
                                     year_of_construction: year_of_constructionPost as! String?,
                                     price: pricePost as! String?,
                                     description: descriptionPost as! String?,
                                     contact: contactPost as! String?,
                                     imageURL : imagePost as? String
                )
                        
               
                self.postsList.append(post)
                
                }
                self.tableView.reloadData()
        }
            
            
        })
        
        
    }
 
    }

extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        searchAnunturi = scopeData.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
    
}
         




