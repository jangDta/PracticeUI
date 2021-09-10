//
//  CardCollectionViewCell.swift
//  PracticeUI
//
//  Created by a60105114 on 2021/09/06.
//

import UIKit
import Charts

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var chart: PieChartView!
    @IBOutlet weak var percentLabel: UILabel!
    
    var percents: [Double] = [80.0, 20.0]
    var colors: [UIColor] = [#colorLiteral(red: 0, green: 0.7396761775, blue: 0.7135596275, alpha: 1), #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9607843137, alpha: 1)]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1.0
        self.contentView.backgroundColor = .white
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        configureChart()
        percentLabel.text = "\(Int(percents[0]))%"
    }
    
    func configureChart() {
        // NOTE : Percent로 표시
        chart.usePercentValuesEnabled = true
        
        chart.drawSlicesUnderHoleEnabled = false
        
        // NOTE : 중앙홀 크기 조정
        chart.holeRadiusPercent = 0.90
        chart.transparentCircleRadiusPercent = 0.9
        chart.chartDescription?.enabled = false
        chart.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
        
        chart.drawCenterTextEnabled = true
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        chart.centerAttributedText = nil;
        
        // NOTE : 중앙홀 사용여부
        chart.drawHoleEnabled = true
        chart.holeColor = UIColor.clear
        chart.rotationAngle = 270
        
        chart.rotationEnabled = false
        
        // NOTE : 차트 터치시 확대됨
        chart.highlightPerTapEnabled = false

        let l = chart.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .bottom
        l.orientation = .vertical
        l.drawInside = false
        l.xEntrySpace = 0
        l.yEntrySpace = 0
        l.yOffset = 0
        
        // NOTE : 범례 on/off
        l.enabled = false
        
        let entries = (0 ..< percents.count).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: percents[i])
        }
        
        let set = PieChartDataSet(entries: entries)
        set.drawIconsEnabled = false
        set.sliceSpace = 0
        
        set.colors = colors
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        data.setDrawValues(false)
        
        chart.data = data
        chart.highlightValues(nil)
        
    }

}
