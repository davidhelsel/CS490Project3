//
//  MovieListViewController.swift
//  flixster
//
//  Created by Anderson David on 1/20/23.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        
        cell.configure(with: movie)
        
        return cell
        }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var movies: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=cf62b834e0066d428dfedc5f4200b7a0")!
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                print("Data is nil")
                return
            }
            do {
                let decoder = JSONDecoder()
                
                let response = try decoder.decode(MoviesResponse.self, from: data)
                
                let movies = response.results
                
                DispatchQueue.main.async {
                    self?.movies = movies
                    
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "toDetailView" {
           if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell), let detailViewController = segue.destination as? DetailViewController {
               let movie = movies[indexPath.row]
               detailViewController.movie = movie
           }
       }
       
   }
   
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
       if let indexPath = tableView.indexPathForSelectedRow {
           tableView.deselectRow(at: indexPath, animated: true)
       }
   }
}
