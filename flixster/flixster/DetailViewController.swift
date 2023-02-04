//
//  DetailViewController.swift
//  flixster
//
//  Created by David Helsel on 1/26/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    var movie: Movie!

    
    @IBOutlet weak var avgLabel: UILabel!
    
    @IBOutlet weak var actualPopLabel: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descLabel.text = movie.overview
        titleLabel.text = movie.original_title
        avgLabel.text = "\(movie.vote_average)"
        actualPopLabel.text = "\(movie.popularity)"
        popLabel.text = "Popularity"
        votesLabel.text = "\(movie.vote_count)"
        let end = movie.backdrop_path
        let start = "https://image.tmdb.org/t/p/w185"
        let whole = start + end
        let one = URL(string: whole)
        Nuke.loadImage(with: one!, into: bannerImage)

        // Do any additional setup after loading the view.
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
