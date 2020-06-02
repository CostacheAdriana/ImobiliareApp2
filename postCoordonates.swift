//
//  postCoordonates.swift
//  ImobiliareApp2
//
//  Created by user169246 on 5/27/20.
//  Copyright © 2020 Costache_Adriana. All rights reserved.
//

import Foundation

class postCoordonates{
    
    var id: String?
    var scope: String?
    var city: String?
    var type_of_property: String?
    var price : String?
    var latitude : String?
    var longitude: String?
  
    
    
    init(id: String?, scope: String?, city: String?,
         type_of_property: String?,
         price:String?, latitude: String?, longitude: String?)
    {
        
        self.id = id;
        self.scope = scope;
        self.city = city;
        self.type_of_property = type_of_property;
        self.price = price;
    }
    }

