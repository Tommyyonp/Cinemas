//
//  HomeTableViewCell.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import UIKit
import SnapKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    
    static let identifer = "HomeTableViewCell"
    
    private lazy var containerView = UIView()
    private lazy var movieImg = UIImageView()
    private lazy var movieTitle = UILabel()
    private lazy var releaseLbl = UILabel()
    private lazy var descLbl = UILabel()
    private lazy var stackView = UIStackView()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(movie: Movie) {
        
        contentView.addSubview(containerView)
        containerView.dropShadow()
        containerView.roundedCorner()
        containerView.backgroundColor = .white
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(12)
        }
        
        movieImg.backgroundColor = .gray
        movieImg.roundedCorner()
        containerView.addSubview(movieImg)
        movieImg.snp.makeConstraints { make in
            make.left.bottom.top.equalTo(containerView).inset(24)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        movieTitle.textColor = .black
        movieTitle.text = "Pirate of Carribean 2: The Awaken Kraken"
        movieTitle.numberOfLines = 0
        movieTitle.font = .systemFont(ofSize: 20, weight: .semibold)
        
        releaseLbl.textColor = .black
        releaseLbl.text = "Sep 20, 2021"
        releaseLbl.numberOfLines = 0
        releaseLbl.font = .systemFont(ofSize: 14, weight: .light)
        
        descLbl.textColor = .black
        descLbl.text = "Description"
        descLbl.font.withSize(16)
        descLbl.numberOfLines = 0
        
        containerView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .leading
        stackView.spacing = 6
        stackView.contentMode = .scaleToFill
        stackView.addArrangedSubview(movieTitle)
        stackView.addArrangedSubview(releaseLbl)
        stackView.addArrangedSubview(descLbl)
        stackView.snp.makeConstraints { make in
            make.left.equalTo(movieImg.snp.right).inset(-24)
            make.top.bottom.right.equalTo(containerView).inset(24)
        }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w185/\(movie.poster_path)")
        self.movieTitle.text = movie.title
        if movie.release_date != "" {
            releaseLbl.text = "Release on \(movie.release_date!.getDateString(separator: "-"))"
        } else {
            releaseLbl.text = "Unknown Release Date"
        }
        self.descLbl.text = movie.overview
        self.movieImg.sd_setImage(with: url, completed: nil)
        self.movieImg.roundedCorner(width: 0)
    }
}
