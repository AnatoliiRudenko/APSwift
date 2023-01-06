//
//  CheckBox.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 24.12.2021.
//

import UIKit

open class CheckBox: BaseView {
    
    // MARK: - Props
    public var isChecked: Bool = false {
        didSet {
            imageView.image = isChecked ? checkedImage : uncheckedImage
        }
    }
    
    public var didTapToState: DataClosure<Bool>?
    
    open func setImages(checkedImage: UIImage?, uncheckedImage: UIImage?) {
        self.checkedImage = checkedImage
        self.uncheckedImage = uncheckedImage
        imageView.image = isChecked ? checkedImage : uncheckedImage
    }
    
    // MARK: - Init
    private var checkedImage: UIImage?
    private var uncheckedImage: UIImage?
    
    convenience public init(checkedImage: UIImage?, uncheckedImage: UIImage?) {
        self.init(frame: .zero)
        setImages(checkedImage: checkedImage, uncheckedImage: uncheckedImage)
        imageView.image = uncheckedImage
    }
    
    open override func setupComponents() {
        super.setupComponents()
        animatesTap = false
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        didTap = { [weak self] in
            self?.handleTap()
        }
    }
    
    // MARK: - UI Properties
    public let imageView: UIImageView = {
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
