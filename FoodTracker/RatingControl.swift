//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Mac on 2019/10/24.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK:Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet{
            updateButtonSelectionState()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setupButtons()
        }
    }
    
    
    //MARK:Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK:Button Action
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("the button,\(button),is not the member of \(ratingButtons)")
        }
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
        
    }
    
    //MARK:Private Methods
    private func setupButtons() {
        //remove all button
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
            
        }
        ratingButtons.removeAll()
        
        for index in 0..<starCount {
            //load button images
            let bundle = Bundle(for: type(of: self))
            let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
            let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
            let hignlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
            
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(hignlightedStar, for: .highlighted)
            button.setImage(hignlightedStar, for: [.selected, .highlighted])
            
            //Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //Add accessibility function
            button.accessibilityLabel = "Set \(index + 1) star rating"
        
            //Setup button actions
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
            //Add button to the stack
            addArrangedSubview(button)
            
            //add button to array
            ratingButtons.append(button)
            
        }
        
        updateButtonSelectionState()
        
    }
    
    //update button UI
    private func updateButtonSelectionState() {
        for(index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
            //Set the hint string for currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset rating to zero"
            } else {
                hintString = nil
            }
            
            let valueString: String
            switch rating {
            case 0:
                valueString = "no rating set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set"
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            
        }
        
    }
}
