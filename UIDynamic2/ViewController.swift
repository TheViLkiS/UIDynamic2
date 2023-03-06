//
//  ViewController.swift
//  UIDynamic2
//
//  Created by Дмитрий Гусев on 02.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //UIAttachmentBehavior - привязка
    //UISnapBehavior - снимок
    
    var squareView = UIView()
    var squareViewAnchorView = UIView()
    var anchorView = UIView()
    var animator = UIDynamicAnimator()
    var attachmentBehavior: UIAttachmentBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        createSmallSquareView()
        createGestureRecognizer()
        createAnchorView()
        createAnimationAndBehaviors()
    }

    
    // создаем квадрат и в нем еще один
    func createSmallSquareView() {
        squareView = UIView(frame: CGRect(x:0 , y: 0, width: 80, height: 80))
        squareView.backgroundColor = .green
        squareView.center = view.center
        squareViewAnchorView = UIView(frame: CGRect(x: 60, y: 0, width: 20, height: 20))
        squareViewAnchorView.backgroundColor = .brown
        squareView.addSubview(squareViewAnchorView)
        view.addSubview(squareView)
    }

    //view с точкой привязки
    func createAnchorView() {
        anchorView = UIView(frame: CGRect(x: 120, y: 120, width: 20, height: 20))
        anchorView.backgroundColor = .red
        view.addSubview(anchorView)
    }
    
    // создадим регистратор жеста паранормирования
    func createGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handletPan(paramPan: )))
        
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    // Создаем столкновение и прикрепление
    func createAnimationAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: view)
        // столкновения
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        // прикрепления
        attachmentBehavior = UIAttachmentBehavior(item: squareView, attachedToAnchor: anchorView.center)
        animator.addBehavior(collision)
        animator.addBehavior(attachmentBehavior!)
    }
    
     // определяет где палец туда где красный квадрат а потом привязка к большому
    @objc func handletPan(paramPan: UIPanGestureRecognizer) {
        let tapPoint = paramPan.location(in: view)
        print(tapPoint)
        attachmentBehavior?.anchorPoint = tapPoint
        anchorView.center = tapPoint
    }
    
}


