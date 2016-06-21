//
//  MoviesViewController.swift
//  Movie
//
//  Created by taiki on 6/21/16.
//  Copyright © 2016 yashigani. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController, MovieRepositoryProvider {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func addTapped(_: UIBarButtonItem) {
        let alert = UIAlertController(title: "new movie?", message: nil, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler {
            $0.placeholder = "title"
        }
        alert.addTextFieldWithConfigurationHandler {
            $0.placeholder = "director"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .Default) { _ in
            guard let
                title = alert.textFields?[0].text,
                director = alert.textFields?[1].text where !title.isEmpty && !director.isEmpty
            else {
                return
            }

            self.repository.addMovie(Movie(title: title, director: director))
            self.tableView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.allMovies.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movie = repository.allMovies[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.director
        return cell
    }

}

// mocking repository
//private var inMemoriRepository: MovieRepositoryProtocol = {
//    var repository = InMemoryRepository()
//    repository.addMovie(Movie(title: "Back to the Future", director: "Robert Zemeckis"))
//    repository.addMovie(Movie(title: "Back to the Future PART 2", director: "Robert Zemeckis"))
//    repository.addMovie(Movie(title: "Back to the Future PART 3", director: "Robert Zemeckis"))
//    return repository
//}()
//extension MovieRepositoryProvider where Self: MoviesViewController {
//    var repository: MovieRepositoryProtocol {
//        return inMemoriRepository
//    }
//}
