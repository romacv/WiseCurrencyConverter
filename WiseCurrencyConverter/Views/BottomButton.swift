//
//  BottomButton.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import UIKit

class BottomButton: UIButton, Themed {
    
    // MARK: - Themed Protocol Properties
    
    var theme: ThemeProvider = AppTheme.shared
    
    // MARK: - Properties
    
    var buttonTappedHandler: (() -> Void)?
    
    private static let cornerRadius: CGFloat = 32
    private var tapAnimator: UIViewPropertyAnimator?
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - ButtonState
    
    enum ButtonState {
        case enabled
        case disabled
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupUI()
        setupAction()
        applyTheme()
        setupActivityIndicator()
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        layer.cornerRadius = BottomButton.cornerRadius
        clipsToBounds = true
    }
    
    private func setupAction() {
        let buttonAction = UIAction { [weak self] _ in
            self?.buttonTappedHandler?()
            self?.startTapAnimation()
        }
        addAction(buttonAction, for: [.touchDown, .touchDragEnter])
        
        let cancelAction = UIAction { [weak self] _ in
            self?.stopTapAnimation()
        }
        addAction(cancelAction, for: [.touchUpInside, .touchDragExit, .touchCancel])
    }
    
    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Animation
    
    private func startTapAnimation() {
        tapAnimator?.stopAnimation(true)
        tapAnimator = UIViewPropertyAnimator(duration: 0.15, curve: .easeInOut) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
            self?.alpha = 0.75
        }
        tapAnimator?.startAnimation()
    }
    
    private func stopTapAnimation() {
        tapAnimator?.stopAnimation(true)
        tapAnimator = nil
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.transform = .identity
            self?.alpha = 1.0
        }
    }
    
    // MARK: - Public Methods
    
    func setupText(_ text: String) {
        setTitle(text, for: .normal)
    }
    
    func updateAppearance(for state: ButtonState, isRounded: Bool) {
        switch state {
        case .enabled:
            self.backgroundColor = theme.enabledBackgroundColor
            setTitleColor(theme.enabledTextColor, for: .normal)
            isEnabled = true
        case .disabled:
            self.backgroundColor = theme.disabledBackgroundColor
            setTitleColor(theme.disabledTextColor, for: .disabled)
            isEnabled = false
        }
        layer.cornerRadius = isRounded ? BottomButton.cornerRadius : 0
    }
    
    func loading(isActive: Bool) {
        isActive ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    // MARK: - Themed Protocol Methods
    
    func applyTheme() {
        let font = theme.buttonFont
        titleLabel?.font = font
    }
    
}
