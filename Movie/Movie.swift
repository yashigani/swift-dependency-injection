//
//  Movie.swift
//  Movie
//
//  Created by taiki on 2016/06/08.
//  Copyright © 2016年 yashigani. All rights reserved.
//

import Foundation

public struct Movie {
    let title: String
    let director: String
}

extension Movie: Equatable {}
public func == (lhs: Movie, rhs: Movie) -> Bool {
    return lhs.title == rhs.title && lhs.director == rhs.director
}
