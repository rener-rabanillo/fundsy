import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'insights_chat_tab.dart';

/// InsightsScreen displays AI-driven financial summaries, cash flow forecasting charts,
/// and an interactive chat assistant tab (Ask).
class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  int selectedTab = 0; // 0 for Analysis tab, 1 for Ask tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Analysis / Ask Toggle Switch Tabs matching the category pill style
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  children: [
                    _buildTabButton('Analysis', 0),
                    _buildTabButton('Ask', 1),
                  ],
                ),
              ),
            ),

            // Dynamic body view: Switches between Analysis dashboard and Chat UI based on selected tab
            Expanded(
              child: selectedTab == 0 ? _buildAnalysisView() : const InsightsChatTab(),
            ),
          ],
        ),
      ),
    );
  }

  /// Analysis Tab Content (Summary, Cash Flow Forecasting, Risk Evaluation)
  Widget _buildAnalysisView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      children: [
        // 1. Summary Card (AI Insight Description)
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: Colors.grey.shade100, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AI Financial Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Your monthly spending decreased by 12% compared to last month. Utilities and groceries make up 65% of your total expenses. Keep up the good work maintaining your savings goal!',
                style: TextStyle(
                  fontSize: 13.5,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 2. Cash Flow Forecasting Card (Powered by fl_chart)
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: Colors.grey.shade100, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Cash Flow Forecasting',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Icon(Icons.more_horiz_rounded, color: Colors.grey.shade400),
                ],
              ),
              const SizedBox(height: 24),

              // Interactive Line Chart Widget using fl_chart
              SizedBox(
                height: 170,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.shade100,
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 35,
                          getTitlesWidget: (value, meta) {
                            if (value == 50000) return const Text('₱50k', style: TextStyle(fontSize: 10, color: Colors.grey));
                            if (value == 25000) return const Text('₱25k', style: TextStyle(fontSize: 10, color: Colors.grey));
                            if (value == 0) return const Text('₱0', style: TextStyle(fontSize: 10, color: Colors.grey));
                            return const Text('');
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 24,
                          getTitlesWidget: (value, meta) {
                            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                            int index = value.toInt();
                            if (index >= 0 && index < months.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(months[index], style: const TextStyle(fontSize: 9.5, color: Colors.grey, fontWeight: FontWeight.w600)),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 11,
                    minY: 0,
                    maxY: 50000,
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 16000),
                          FlSpot(1, 24000),
                          FlSpot(2, 19000),
                          FlSpot(3, 36000),
                          FlSpot(4, 42000),
                          FlSpot(5, 27000),
                          FlSpot(6, 39000),
                          FlSpot(7, 21000),
                          FlSpot(8, 17000),
                          FlSpot(9, 26000),
                          FlSpot(10, 33000),
                          FlSpot(11, 31000),
                        ],
                        isCurved: true,
                        color: const Color(0xFF1A0B8C),
                        barWidth: 3,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: const Color(0xFF1A0B8C).withValues(alpha: 0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Forecasting trend commentary text
              Text(
                'Based on historical trends, your cash flow is projected to increase steadily from October through December due to anticipated holiday income bonuses.',
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 3. Financial Risk Evaluation Card
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: Colors.grey.shade100, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Financial Risk Evaluation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 180,
                  height: 90,
                  child: CustomPaint(
                    painter: RiskGaugePainter(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Low Risk',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A0B8C),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  /// Helper builder for toggle tab buttons (Analysis / Ask) with solid dark blue active style
  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index; // Switches tab and updates UI state
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            // Uses solid dark blue/indigo for selected tab, transparent for unselected
            color: isSelected ? const Color(0xFF1A0B8C) : Colors.transparent,
            borderRadius: BorderRadius.circular(24.0),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              // White text for selected tab, grey for unselected
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter responsible for rendering the semi-circle financial risk gauge
class RiskGaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintArc = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintProgress = Paint()
      ..color = const Color(0xFF1A0B8C)
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
    canvas.drawArc(rect, 3.14, 3.14, false, paintArc);
    canvas.drawArc(rect, 3.14, 1.2, false, paintProgress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}