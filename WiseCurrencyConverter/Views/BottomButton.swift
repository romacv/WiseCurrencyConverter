//
//  BottomButton.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import UIKit

class BottomButton: UIButton, Themed {
    // MARK: - ButtonState
    
    enum ButtonState {
        case enabled
        case disabled
    }
    
    // MARK: - Properties
    
    var buttonTappedHandler: (() -> Void)?
    
    private static let cornerRadius: CGFloat = 32
    private var tapAnimator: UIViewPropertyAnimator?
    var theme: ThemeProvider = AppTheme.shared
    
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
    }
    
    private func setupUI() {
        layer.cornerRadius = BottomButton.cornerRadius
        clipsToBounds = true
        applyTheme(theme: theme)
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
    
    // MARK: - Themed methods
    
    func applyTheme(theme: ThemeProvider) {
        self.theme = theme
        let font = theme.buttonFont
        titleLabel?.font = font
    }
}
