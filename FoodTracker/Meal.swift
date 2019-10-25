//
//  Meal.swift
//  FoodTracker
//
//  Created by Mac on 2019/10/25.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
class Meal{
    //MARK:Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    init?(name: String, photo: UIImage?, rating: Int) {
        //validate the parameters value
        guard !name.isEmpty else {
            return nil
        }
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        //initialize the value
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}

