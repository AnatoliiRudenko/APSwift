//
//  CheckBox.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 24.12.2021.
//

import UIKit

class CheckBox: BaseView {
    
    private var checkedImage: UIImage?
    private var uncheckedImage: UIImage?
    
    func setImages(checkedImage: UIImage?, uncheckedImage: UIImage?) {
        self.checkedImage = checkedImage
        self.uncheckedImage = uncheckedImage
        self.updateComponents()
    }
    
    convenience init(checkedImage: UIImage?, uncheckedImage: UIImage?) {
        self.init(frame: .zero)
        setImages(checkedImage: checkedImage, uncheckedImage: uncheckedImage)
        imageView.image = uncheckedImage
    }

    // MARK: - Props
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var isChecked: Bool = false {
        didSet {
            self.updateComponents()
        }
    }
    
    var didTapToState: DataClosure<Bool>?
    
    // MARK: - Methods
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
    
    override func updateComponents() {
        super.updateComponents()
        
        self.imageView.image = isChecked ? checkedImage : uncheckedImage
    }
    
    private func handleTap() {
        self.isChecked.toggle()
        self.didTapToState?(self.isChecked)
    }
}
