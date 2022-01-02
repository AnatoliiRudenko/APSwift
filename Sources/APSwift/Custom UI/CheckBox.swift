//
//  CheckBox.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 24.12.2021.
//

import UIKit

class CheckBox: BaseView {
    
    // MARK: - Props
    
    var isChecked: Bool = false {
        didSet {
            imageView.image = isChecked ? checkedImage : uncheckedImage
        }
    }
    
    var didTapToState: DataClosure<Bool>?
    
    func setImages(checkedImage: UIImage?, uncheckedImage: UIImage?) {
        self.checkedImage = checkedImage
        self.uncheckedImage = uncheckedImage
        imageView.image = isChecked ? checkedImage : uncheckedImage
    }
    
    // MARK: - Init
    private var checkedImage: UIImage?
    private var uncheckedImage: UIImage?
    
    convenience init(checkedImage: UIImage?, uncheckedImage: UIImage?) {
        self.init(frame: .zero)
        setImages(checkedImage: checkedImage, uncheckedImage: uncheckedImage)
        imageView.image = uncheckedImage
    }
    
    override func setupComponents() {
        super.setupComponents()
        animateTap = false
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        didTap = { [weak self] in
            self?.handleTap()
        }
    }
    
    // MARK: - UI Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
}

// MARK: - Supporting methods
extension CheckBox {
    
    private func handleTap() {
        self.isChecked.toggle()
        self.didTapToState?(self.isChecked)
    }
}
