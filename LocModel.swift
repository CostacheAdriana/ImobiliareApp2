//
//  LocModel.swift
//  ImobiliareApp2
//
//  Created by user169246 on 5/27/20.
//  Copyright © 2020 Costache_Adriana. All rights reserved.
//


class LocModel {
    var id: String?
    var latitude: String?
    var longitude: String?
    
    init(id:String? , latitude:String?, longitude: String){
        
        self.id = id;
        self.latitude = latitude;
        self.longitude = longitude;
    }
}

