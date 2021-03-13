import UIKit

class GradientViewLesson2: UIView {
    var TopColor: UIColor = #colorLiteral(red: 0.2, green: 0.5490196078, blue: 1, alpha: 1)
    var BotColor: UIColor = #colorLiteral(red: 0.06274509804, green: 0.1764705882, blue: 0.631372549, alpha: 1)
    
    var StartPointX: CGFloat = 0
    var StartPointY: CGFloat = 0
    var EndPointX: CGFloat = 1
    var EndPointY: CGFloat = 1
    
    override func layoutSubviews() {
        let gradientView = CAGradientLayer()
        gradientView.colors = [TopColor.cgColor, BotColor.cgColor]
        gradientView.startPoint = CGPoint(x: StartPointX, y: StartPointY)
        gradientView.endPoint = CGPoint(x: EndPointX, y: EndPointY)
        gradientView.frame = self.bounds
        self.layer.insertSublayer(gradientView, at: 0)
    }

}
