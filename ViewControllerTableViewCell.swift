//
//  ViewControllerTableViewCell.swift
//  ImobiliareApp2
//
//  Created by user169246 on 5/24/20.
//  Copyright © 2020 Costache_Adriana. All rights reserved.
//

import UIKit
import Kingfisher
class ViewControllerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ScopeLabel: UILabel!
    
 
    @IBOutlet weak var TypeOfProperty: UILabel!
    @IBOutlet weak var SurfaceLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    
    @IBOutlet weak var RoomsLabel: UILabel!
    
    @IBOutlet weak var YearC: UILabel!
    
    @IBOutlet weak var PriceLabel: UILabel!
    
    @IBOutlet weak var ContactLabel: UILabel!
    
    @IBOutlet weak var DescText: UITextView!
    
    @IBOutlet weak var PostImage: UIImageView!
    

    
    
    @IBOutlet weak var NumberOfRoomsLabel: UILabel!
    var postModel: PostModel?{
        didSet{
            let url = URL(string: (postModel?.imageURL)!)
            if let url = url as? URL{
                KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) {(image,error, cache, imageURL) in
                    self.PostImage.image = image
                    self.PostImage.kf.indicatorType = .activity
                    self.ScopeLabel.text = self.postModel?.scope
                    self.CityLabel.text = self.postModel?.city
                    self.TypeOfProperty.text = self.postModel?.type_of_property
                    self.SurfaceLabel.text = self.postModel?.surface
                    self.RoomsLabel.text = self.postModel?.number_of_rooms
                    self.YearC.text = self.postModel?.year_of_construction
                    self.PriceLabel.text = self.postModel?.price
                    self.ContactLabel.text = self.postModel?.contact
                    self.DescText.text = self.postModel?.description
                    
                }
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

   
