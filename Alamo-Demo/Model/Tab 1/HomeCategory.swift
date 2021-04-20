//
//  CountryCategory.swift
//  Alamo-Demo
//
//  Created by Akshay on 4/19/21.
//  Copyright © 2021 Pooja Mahajan. All rights reserved.
//

import UIKit

struct HomeCategory: Decodable {
    let main: [MainCategory]
    let country: [CountryCategory]
}

struct MainCategory: Decodable {
    let categoryId: String
    let categoryName: String
    let categoryImage: String
}

struct CountryCategory: Decodable {
    let countryID: String
    let countryName: String
    let countryImage: String
}
