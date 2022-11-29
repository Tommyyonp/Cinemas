//
//  ReviewTableViewCell.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 28/11/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    static let identifier = "ReviewTableViewCell"
    
    private lazy var containerView = UIView()
    private lazy var userLbl = UILabel()
    private lazy var commentLbl = UILabel()
    var stackView = UIStackView()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell() {
        
        contentView.addSubview(containerView)
        containerView.dropShadow()
        containerView.roundedCorner()
        containerView.backgroundColor = .white
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(12)
        }
        
        userLbl.textColor = .black
        userLbl.text = "User"
        userLbl.numberOfLines = 0
        userLbl.font = .systemFont(ofSize: 16, weight: .semibold)
        
        commentLbl.textColor = .black
        commentLbl.text = "Comment"
        commentLbl.numberOfLines = 0
        commentLbl.font = .systemFont(ofSize: 12, weight: .light)
        
        containerView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .top
        stackView.spacing = 3
        stackView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(userLbl)
        stackView.addArrangedSubview(commentLbl)
        stackView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(containerView).inset(12)
        }
        
//        let url = URL(string: "https://image.tmdb.org/t/p/w185/\(movie.poster_path)")
//        self.movieTitle.text = movie.title
//        if movie.release_date != "" {
//            releaseLbl.text = "Release on \(movie.release_date!.getDateString(separator: "-"))"
//        } else {
//            releaseLbl.text = "Unknown Release Date"
//        }
//        self.descLbl.text = movie.overview
//        self.movieImg.sd_setImage(with: url, completed: nil)
//        self.movieImg.roundedCorner(width: 0)
//        self.userLbl.text = 
    }
}
