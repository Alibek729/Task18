
import UIKit
import SnapKit

class MovieCell: UITableViewCell {
    
    lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var contentText: UILabel = {
        let label = UILabel()
        label.text = "label"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(headerTitle)
        stackView.addArrangedSubview(contentText)
        return stackView
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        
        stackView.addArrangedSubview(userImage)
        stackView.addArrangedSubview(vStackView)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hStackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        hStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(5)
            make.bottom.equalTo(contentView.snp.bottom).inset(5)
            make.leading.equalTo(contentView.snp.leading).inset(10)
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
        }
    }
}
