//
//  MNCollectionViewFlowLayout.swift
//  mangonote
//
//  Created by Huang Zhen on 2017/8/30.
//  Copyright © 2017年 Huang Zhen. All rights reserved.
//

import UIKit

class MNCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    private var animator : UIDynamicAnimator?
    
    override func prepare() {
        super.prepare()
        if nil === animator {
            animator = UIDynamicAnimator.init(collectionViewLayout: self)
            let size = self.collectionViewContentSize
            let items = super.layoutAttributesForElements(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
            for item in items! {
                let spring = UIAttachmentBehavior.init(item: item, attachedToAnchor: item.center)
                spring.length = 0
                spring.damping = 1
                spring.frequency = 1
                animator!.addBehavior(spring)
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return animator!.items(in: rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return animator!.layoutAttributesForCell(at: indexPath)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let scrollView = self.collectionView
        let scrollDelta = newBounds.origin.y - (scrollView?.bounds.origin.y)!
        
        let touchLocation = scrollView?.panGestureRecognizer.location(in: scrollView)
        for spring in animator!.behaviors {
            if let attBehavior = spring as? UIAttachmentBehavior {
                let anchorPoint = attBehavior.anchorPoint
                let distanceFromTouch = fabs((touchLocation?.y)! - anchorPoint.y)
                let scrollResistance = distanceFromTouch / 1000
                
                if let item = attBehavior.items.first as? UICollectionViewLayoutAttributes {
                    var center = item.center
                    center.y += (scrollDelta > 0) ? min(scrollDelta, scrollDelta * scrollResistance) : max(scrollDelta, scrollDelta * scrollResistance)
                    item.center = center
                    animator!.updateItem(usingCurrentState: item)
                }
            }
        }
        return false
    }
}
