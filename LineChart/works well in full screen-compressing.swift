
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
        chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chartView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        chartView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupChart() {
        chartView = LineChartView()
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(addDataEntry), userInfo: nil, repeats: true)
    }
    
    @objc func addDataEntry() {
        let newEntry = ChartDataEntry(x: Double(dataEntries.count), y: Double.random(in: 0..<100))
        dataEntries.append(newEntry)
        
        let set = LineChartDataSet(entries: dataEntries, label: "Line Chart")
        set.mode = .cubicBezier
        set.lineWidth = 2
        set.setColor(.blue)
        set.drawCirclesEnabled = false
        set.drawValuesEnabled = false
        
        let data = LineChartData(dataSet: set)
        chartView.data = data
        chartView.notifyDataSetChanged()
    }
}
