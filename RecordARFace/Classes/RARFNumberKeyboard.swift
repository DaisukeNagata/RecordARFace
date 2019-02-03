//
//  RARFNumberKeyboard.swift
//  SamapleKeyBoard
//
//  Created by 永田大祐 on 2019/02/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

public final class RARFNumberKeyboard: UIView {
    
    @IBOutlet weak var one: RARFNumberButton!
    @IBOutlet weak var two: RARFNumberButton!
    @IBOutlet weak var three: RARFNumberButton!
    @IBOutlet weak var four: RARFNumberButton!
    @IBOutlet weak var five: RARFNumberButton!
    @IBOutlet weak var six: RARFNumberButton!
    @IBOutlet weak var seven: RARFNumberButton!
    @IBOutlet weak var eight: RARFNumberButton!
    @IBOutlet weak var nine: RARFNumberButton!
    @IBOutlet weak var zero: RARFNumberButton!
    @IBOutlet weak var minus: RARFNumberButton!
    @IBOutlet weak var plus: RARFNumberButton!
    @IBOutlet weak var enter: RARFNumberButton!
    
    @IBOutlet weak var abc: UIView!



    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        loadNib()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    func loadNib(){
        let view = Bundle.main.loadNibNamed("RARFNumberKeyboard", owner: self, options: nil)?.first as! UIView
        view.frame = UIScreen.main.bounds
        view.frame.origin.y = UIScreen.main.bounds.height
        UIView.animate(withDuration: 1.0) {
            view.frame.origin.y -= UIScreen.main.bounds.height/1.5
            self.addSubview(view)
        }
    }
}
