//
//  PostersViewController.swift
//  flixster
//
//  Created by David Helsel on 2/4/23.
//

import UIKit
import Nuke

class PostersViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        let movie = movies[indexPath.item]
        
        let end = movie.poster_path
        let start = "https://image.tmdb.org/t/p/w185"
        let whole = start + end
        
        let one = URL(string: whole)
        Nuke.loadImage(with: one!, into: cell.posterImage)
        
        return cell
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
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
                    
                    self?.collectionView.reloadData()
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumInteritemSpacing = 1
        
        layout.minimumLineSpacing = 1
        
        let numberOfColumns: CGFloat = 3
        
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns
        
        
        layout.itemSize = CGSize(width: width, height: width*2)

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "toDetailView2" {
           if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell), let detailViewController = segue.destination as? DetailViewController {
               let movie = movies[indexPath.row]
               detailViewController.movie = movie
           }
       }
       
   }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
