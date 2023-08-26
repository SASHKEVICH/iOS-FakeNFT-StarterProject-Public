import UIKit

final class CartPaymentCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    private enum Constants {
        static let cornerRadius: CGFloat = 12
        static let labelsLineHeight: CGFloat = 18

        static let currencyImageViewInsets = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 0)

        static let titleLabelTopInset: CGFloat = 4
        static let labelsSideInset: CGFloat = 4
    }

    var currency: CurrencyCellViewModel? {
        didSet {
            self.currencyImageView.image = self.currency?.image
            self.titleLabel.text = self.currency?.title
            self.shortNameLabel.text = self.currency?.name

            self.titleLabel.lineHeight = Constants.labelsLineHeight
            self.shortNameLabel.lineHeight = Constants.labelsLineHeight
        }
    }

    private lazy var currencyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Constants.cornerRadius / 2
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .appBlackOnly
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .appBlack
        label.font = .getFont(style: .regular, size: 13)
        return label
    }()

    private let shortNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .greenUniversal
        label.font = .getFont(style: .regular, size: 13)
        return label
    }()

    private lazy var selectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.borderColor = UIColor.appBlack.cgColor
        view.layer.borderWidth = 2
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.contentView.layer.borderColor = UIColor.appBlack.cgColor
    }
}

extension CartPaymentCollectionViewCell {
    func shouldSelectCell(_ shouldSelect: Bool) {
        self.contentView.layer.borderWidth = shouldSelect ? 1 : 0
    }
}

private extension CartPaymentCollectionViewCell {
    func configure() {
        self.contentView.backgroundColor = .appLightGray
        self.contentView.layer.cornerRadius = Constants.cornerRadius
        self.contentView.layer.borderColor = UIColor.appBlack.cgColor
        self.contentView.layer.borderWidth = 0

        self.addSubviews()
        self.addConstraints()
    }

    func addSubviews() {
        self.contentView.addSubview(self.currencyImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.shortNameLabel)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            self.currencyImageView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: Constants.currencyImageViewInsets.top
            ),
            self.currencyImageView.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: Constants.currencyImageViewInsets.left
            ),
            self.currencyImageView.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: -Constants.currencyImageViewInsets.bottom
            ),
            self.currencyImageView.widthAnchor.constraint(equalTo: self.currencyImageView.heightAnchor),

            self.titleLabel.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: Constants.titleLabelTopInset
            ),
            self.titleLabel.leadingAnchor.constraint(
                equalTo: self.currencyImageView.trailingAnchor,
                constant: Constants.labelsSideInset
            ),

            self.shortNameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.shortNameLabel.leadingAnchor.constraint(
                equalTo: self.currencyImageView.trailingAnchor,
                constant: Constants.labelsSideInset
            )
        ])
    }
}
