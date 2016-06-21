//
//  MovieRepository.swift
//  Movie
//
//  Created by taiki on 2016/06/08.
//  Copyright © 2016年 yashigani. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol {
    func setObject(object: AnyObject?, forKey: String)
    func objectForKey(key: String) -> AnyObject?
}

extension NSUserDefaults: UserDefaultsProtocol {}

class PlistRepository: MovieRepositoryProtocol {
    let userDefaults: UserDefaultsProtocol
    var allMovies: [Movie] {
        guard let objects = userDefaults.objectForKey("allmovies") as? [[String: String]] else {
            return []
        }

        let movies = objects.flatMap { object -> Movie? in
            if let title = object["title"], director = object["director"] {
                return Movie(title: title, director: director)
            }
            return nil
        }
        return movies
    }

    init(userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
    }

    func addMovie(movie: Movie) {
        var allMovies: [[String: String]]
        if let objects = userDefaults.objectForKey("allmovies") as? [[String: String]] {
            allMovies = objects
        } else {
            allMovies = []
        }
        allMovies.append(movie.dictionary)
        userDefaults.setObject(allMovies, forKey: "allmovies")
    }

    func findMovie(by director: String) -> [Movie] {
        return allMovies.filter { $0.director == director }
    }

}

extension Movie {
    var dictionary: [String: String] {
        return ["title": title, "director": director]
    }
}

protocol MovieRepositoryProtocol {
    var allMovies: [Movie] { get }

    func addMovie(movie: Movie)
    func findMovie(by director: String) -> [Movie]
}

protocol MovieRepositoryProvider {
    var repository: MovieRepositoryProtocol { get }
}

class InMemoryRepository: MovieRepositoryProtocol {
    private var movies = [Movie]()
    var allMovies: [Movie] { return movies }

    func addMovie(movie: Movie) {
        movies.append(movie)
    }

    func findMovie(by director: String) -> [Movie] {
        return movies.filter { $0.director == director }
    }

}
