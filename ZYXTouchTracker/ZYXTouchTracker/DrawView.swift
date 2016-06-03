//
//  DrawView.swift
//  ZYXTouchTracker
//
//  Created by 卓酉鑫 on 16/6/3.
//  Copyright © 2016年 卓酉鑫. All rights reserved.
//

import UIKit

class DrawView: UIView, UIGestureRecognizerDelegate
{
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    var selectedLineIndex: Int?
    var moveRecognizer: UIPanGestureRecognizer!
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.blackColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.redColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineInThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.requireGestureRecognizerToFail(doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        addGestureRecognizer(longPressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DrawView.moveLine(_:)))
        moveRecognizer.cancelsTouchesInView = false
        moveRecognizer.delegate = self
        addGestureRecognizer(moveRecognizer)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func moveLine(gestureRecognizer: UIPanGestureRecognizer)
    {
        print("Recognized a pan")
        
        if let index = selectedLineIndex
        {
            if gestureRecognizer.state == .Changed
            {
                let translation = gestureRecognizer.translationInView(self)
                finishedLines[index].begin.x += translation.x
                finishedLines[index].begin.y += translation.y
                finishedLines[index].end.x += translation.x
                finishedLines[index].end.y += translation.y
                
                gestureRecognizer.setTranslation(CGPoint.zero, inView: self)
                
                setNeedsDisplay()
            }
        }
        else
        {
            return
        }
    }
    
    func longPress(gestureRecognizer: UIGestureRecognizer)
    {
        print("Recognized a long press")
        
        if gestureRecognizer.state == .Began
        {
            let point = gestureRecognizer.locationInView(self)
            selectedLineIndex = indexOfLineAtPoint(point)
            
            if selectedLineIndex != nil
            {
                currentLines.removeAll(keepCapacity: false)
            }
        }
        else if gestureRecognizer.state == .Ended
        {
            selectedLineIndex = nil
        }
        
        setNeedsDisplay()
    }
    
    func tap(gestureRecognizer: UIGestureRecognizer)
    {
        print("Recognized a tap")
        
        let point = gestureRecognizer.locationInView(self)
        selectedLineIndex = indexOfLineAtPoint(point)
        
        let menu = UIMenuController.sharedMenuController()
        
        if selectedLineIndex != nil
        {
            becomeFirstResponder()
            
            let deleteItem = UIMenuItem(title: "Delete", action: #selector(DrawView.deleteLine(_:)))
            menu.menuItems = [deleteItem]
            
            menu.setTargetRect(CGRect(x: point.x, y: point.y, width: 2, height: 2), inView: self)
            menu.setMenuVisible(true, animated: true)
        }
        else
        {
            menu.setMenuVisible(false, animated: true)
        }
        
        
        setNeedsDisplay()
    }
    
    func deleteLine(sender: AnyObject)
    {
        if let index = selectedLineIndex
        {
            finishedLines.removeAtIndex(index)
            selectedLineIndex = nil
            setNeedsDisplay()
        }
    }
    
    func doubleTap(gestureRecognizer: UIGestureRecognizer)
    {
        print("Recognized a double tap")
        
        selectedLineIndex = nil
        currentLines.removeAll(keepCapacity: false)
        finishedLines.removeAll(keepCapacity: false)
        
        setNeedsDisplay()
    }
    
    func strokeLine(line: Line)
    {
        let path = UIBezierPath()
        path.lineCapStyle = CGLineCap.Round
        
        path.moveToPoint(line.begin)
        path.addLineToPoint(line.end)
        path.stroke()
    }
    
    func indexOfLineAtPoint(point: CGPoint) -> Int?
    {
        for (index, line) in finishedLines.enumerate()
        {
            let begin = line.begin
            let end = line.end
            
            for t in CGFloat(0).stride(to: 1.0, by: 0.05)
            {
                let x = begin.x + ((end.x - begin.x) * t)
                let y = begin.y + ((end.y - begin.y) * t)
                
                if hypot(x - point.x, y - point.y) < 20.0
                {
                    return index
                }
                
            }
            
        }
        
        return nil
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func drawRect(rect: CGRect) {
        
        finishedLineColor.setStroke()
        for line in finishedLines
        {
            strokeLine(line)
        }
        
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            strokeLine(line)
        }
        
        if let index = selectedLineIndex
        {
            UIColor.greenColor().setStroke()
            let selectedLine = finishedLines[index]
            strokeLine(selectedLine)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print(#function)
        
        for touch in touches
        {
            let location = touch.locationInView(self)
            
            let newLine = Line(begin: location, end: location)
            
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print(#function)
        
        for touch in touches
        {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.locationInView(self)
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        print(#function)
        
        for touch in touches
        {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key]
            {
                line.end = touch.locationInView(self)
                
                finishedLines.append(line)
                currentLines.removeValueForKey(key)
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        print(#function)
        
        currentLines.removeAll()
        setNeedsDisplay()
    }
}
