
import UIKit
import Charts


class ViewController: UIViewController {
    
    var chartView: LineChartView!
    var dataEntries: [ChartDataEntry] = []
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChart()
        setupTimer()
        
        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        chartView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        chartView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setupChart() {
        chartView = LineChartView()
        // Set the chart view's frame
        let chartViewFrame = CGRect(x: 0, y: 0, width: 300, height: 300)
        chartView.frame = chartViewFrame
        chartView.center = view.center
        //
        //        chartView.xAxis.labelPosition = .bottom
        //        chartView.xAxis.drawGridLinesEnabled = false
        //        chartView.rightAxis.enabled = false
        //        chartView.legend.enabled = false
        
        // Set a fixed range of 10 visible values for the x-axis
        chartView.xAxis.setLabelCount(10, force: true)
        chartView.xAxis.axisMinimum = 0
        chartView.xAxis.axisMaximum = 9
        chartView.setVisibleXRangeMaximum(10)
        chartView.backgroundColor = .white
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1/8, target: self, selector: #selector(addDataEntry), userInfo: nil, repeats: true)
    }
    
    
    @objc func addDataEntry() {
        let newEntry = ChartDataEntry(x: Double(dataEntries.count), y: Double.random(in: 0..<110))
        dataEntries.append(newEntry)
        
        let set = LineChartDataSet(entries: dataEntries, label: "Line Chart")
        set.mode = .cubicBezier
        set.lineWidth = 2
        set.setColor(.black)
        set.drawCirclesEnabled = false
        set.drawValuesEnabled = true
        
        let data = LineChartData(dataSet: set)
        chartView.data = data
        // Shift the x-axis to the right as new data is added
        if let xMax = dataEntries.last?.x {
            chartView.xAxis.axisMinimum = xMax > 30 ? xMax - 30 : 0
            chartView.xAxis.axisMaximum = xMax
            chartView.moveViewToX(xMax)
            
            if newEntry.y < 40 {
                print("*****  Line is below 40 *****")
            } else if newEntry.y > 100 {
                print("##### Line is above 100 #####")
            }
        }
        
    }
}
