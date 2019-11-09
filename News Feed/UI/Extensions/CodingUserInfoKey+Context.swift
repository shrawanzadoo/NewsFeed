//
//  CodingUserInfoKey+Context.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 04/08/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import Foundation

public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "context")
}

