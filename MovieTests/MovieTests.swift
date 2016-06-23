//
//  MovieTests.swift
//  MovieTests
//
//  Created by taiki on 2016/06/08.
//  Copyright © 2016年 yashigani. All rights reserved.
//

import XCTest
@testable import Movie


class MovieTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        mockRepository = InMemoryRepository()
        mockRepository.addMovie(Movie(title: "protocol extension", director: "yashigani"))
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testViewController() {
        let vc = MoviesViewController()
        let repository = vc.repository
        XCTAssertEqual(repository.allMovies.count, 1)
        
        let movie = repository.findMovie(by: "yashigani")
        XCTAssertNotNil(movie)
    }
    
}

private var mockRepository: InMemoryRepository!

extension MovieRepositoryProvider where Self: MoviesViewController {
    var repository: MovieRepositoryProtocol {
        return mockRepository
    }
}
