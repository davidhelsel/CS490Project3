//
//  MovieCell.swift
//  flixster
//
//  Created by David Helsel on 1/26/23.
//

import UIKit
import Nuke

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with movie: Movie) {
        movieDescription.text = movie.overview
        movieTitle.text = movie.original_title
        
        let end = movie.poster_path
        let start = "https://image.tmdb.org/t/p/w185"
        let whole = start + end
        
        let one = URL(string: whole)
        Nuke.loadImage(with: one!, into: movieImage)
        
        
    }

}
