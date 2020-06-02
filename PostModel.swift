//
//  PostModel.swift
//  ImobiliareApp2
//
//  Created by user169246 on 5/23/20.
//  Copyright © 2020 Costache_Adriana. All rights reserved.
//

import Foundation

class PostModel{
    
    var id: String?
    var scope: String?
    var city: String?
    var type_of_property: String?
    var number_of_rooms : String?
    var surface : String?
    var year_of_construction : String?
    var price : String?
    var description : String?
    var contact : String?
    var imageURL: String?
    
    
    init(id: String?, scope: String?, city: String?,
         type_of_property: String?, number_of_rooms: String?, surface: String?, year_of_construction: String?,
         price:String?, description: String?, contact: String?, imageURL: String?){
        
        self.id = id;
        self.scope = scope;
        self.city = city;
        self.type_of_property = type_of_property;
        self.number_of_rooms = number_of_rooms;
        self.surface = surface;
        self.year_of_construction = year_of_construction;
        self.price = price;
        self.description = description;
        self.contact = contact;
        self.imageURL = imageURL;
    }
}

