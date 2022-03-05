//
//  Models.swift
//  ImageFetchApp
//
//  Created by Valya on 5.03.22.
//

import UIKit

struct User: Decodable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
    let address: Address?
    let company: Company?
}

struct Company: Decodable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

struct Address: Decodable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

struct Geo: Decodable {
    let lat: String?
    let lng: String?
}

struct Post: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

struct Comment: Decodable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
