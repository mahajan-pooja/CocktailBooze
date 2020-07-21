//
//  Constants.swift
//  Alamo-Demo
//
//  Created by Akshay on 7/20/20.
//  Copyright © 2020 Pooja Mahajan. All rights reserved.
//

import Foundation
import UIKit

public enum Constants {
    static let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    static let quote = "Somewhere in Oprah's mantra is making time for yourself…with an adult beverage.!!"
    enum ExternalHyperlinks {
        static let countryCategory = "https://mahajan-pooja.github.io/cocktail-booz-api/country-category.json"
        static let mainCategory = "https://mahajan-pooja.github.io/cocktail-booz-api/main-category.json"
        static let recipe = "https://mahajan-pooja.github.io/cocktail-booz-api/greentini.json"
        static let videoCategory = "https://mahajan-pooja.github.io/cocktail-booz-api/video-category.json"
        static let wineCategory = "https://mahajan-pooja.github.io/cocktail-booz-api/wine-category.json"
    }
}
