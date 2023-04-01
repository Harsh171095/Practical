//
//  ProductItem.swift
//  demoP
//
//  Created by 200OK-IOS5 on 31/03/23.
//

import Foundation


//{
//      "id": 1,
//      "title": "iPhone 9",
//      "description": "An apple mobile which is nothing like apple",
//      "price": 549,
//      "discountPercentage": 12.96,
//      "rating": 4.69,
//      "stock": 94,
//      "brand": "Apple",
//      "category": "smartphones",
//      "thumbnail": "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
//      "images": [
//        "https://i.dummyjson.com/data/products/1/1.jpg",
//        "https://i.dummyjson.com/data/products/1/2.jpg",
//        "https://i.dummyjson.com/data/products/1/3.jpg",
//        "https://i.dummyjson.com/data/products/1/4.jpg",
//        "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
//      ]
//    }

// MARK: - Welcome

struct Product: Codable {
    let products: [ProductItem]
    let total: Int
    let skip: Int
    let limit: Int
}
struct ProductItem: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
