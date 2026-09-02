import 'package:flutter/material.dart';

class DiseaseStatistics {
  final Map<String, int> counts;
  final DateTime periodStart;
  final DateTime periodEnd;

  DiseaseStatistics({
    required this.counts,
    required this.periodStart,
    required this.periodEnd,
  });

  int get totalCases => counts.values.fold(0, (sum, count) => sum + count);
  String get topDisease => counts.isEmpty ? 'N/A' : counts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
}

class PatientRecord {
  final String id;
  final String name;
  final int age;
  final String sex;
  final String referredFrom;
  final List<String> diagnosis;
  final String diseaseHistory;
  final String sampleType;
  final DateTime collectionDate;
  final List<LabTestResult> tests;
  final double billAmount;
  final List<String> dispatchedTo;

  const PatientRecord({
    required this.id,
    required this.name,
    required this.age,
    required this.sex,
    required this.referredFrom,
    required this.diagnosis,
    required this.diseaseHistory,
    required this.sampleType,
    required this.collectionDate,
    required this.tests,
    required this.billAmount,
    this.dispatchedTo = const [],
  });

  bool get hasProcessingResults => tests.any((test) => test.status == LabStatus.processing);
  bool get hasCompletedResults => tests.any((test) => test.status == LabStatus.completed);

  String get statusLabel {
    if (hasCompletedResults && !hasProcessingResults) return 'Completed';
    if (hasProcessingResults && !hasCompletedResults) return 'Processing';
    return 'In review';
  }
}

class LabTestResult {
  final String name;
  final String value;
  final LabStatus status;
  final double cost;

  const LabTestResult({
    required this.name,
    required this.value,
    required this.status,
    required this.cost,
  });
}

enum LabStatus { completed, processing, pending }

class MockMicrobiologyData {
  static final List<PatientRecord> patients = [
    PatientRecord(
      id: 'MB-2024-001',
      name: 'Priya Sharma',
      age: 34,
      sex: 'Female',
      referredFrom: 'Emergency Department',
      diagnosis: ['Septicemia', 'Urinary tract infection'],
      diseaseHistory: 'Has recurrent UTI episodes and a history of low-grade fever for the past 3 weeks.',
      sampleType: 'Blood culture / Urine',
      collectionDate: DateTime(2026, 8, 26),
      tests: [
        const LabTestResult(
          name: 'CBC with differential',
          value: 'WBC 12.4 x10^9/L; neutrophilia',
          status: LabStatus.completed,
          cost: 2400,
        ),
        const LabTestResult(
          name: 'Blood culture',
          value: 'Staphylococcus aureus isolated',
          status: LabStatus.completed,
          cost: 3600,
        ),
        const LabTestResult(
          name: 'Antibiotic sensitivity',
          value: 'Pending final evaluation',
          status: LabStatus.processing,
          cost: 2800,
        ),
      ],
      billAmount: 8800,
      dispatchedTo: ['Reception Desk', 'Infectious Diseases Unit'],
    ),
    PatientRecord(
      id: 'MB-2024-014',
      name: 'Arjun Reddy',
      age: 48,
      sex: 'Male',
      referredFrom: 'Respiratory Clinic',
      diagnosis: ['HIV-associated infection', 'Pulmonary infection'],
      diseaseHistory: 'History of weight loss, chronic cough, and recurrent respiratory symptoms.',
      sampleType: 'Sputum / Blood',
      collectionDate: DateTime(2026, 8, 27),
      tests: [
        const LabTestResult(
          name: 'Sputum microscopy',
          value: 'Pending direct observation',
          status: LabStatus.processing,
          cost: 1800,
        ),
        const LabTestResult(
          name: 'Blood PCR',
          value: 'Awaiting run completion',
          status: LabStatus.pending,
          cost: 4200,
        ),
      ],
      billAmount: 6000,
      dispatchedTo: ['Pulmonology Unit'],
    ),
    PatientRecord(
      id: 'MB-2024-032',
      name: 'Deepika Singh',
      age: 26,
      sex: 'Female',
      referredFrom: 'Outpatient Clinic',
      diagnosis: ['Gastroenteritis', 'Salmonella screening'],
      diseaseHistory: 'Acute diarrhea and vomiting for 5 days, no prior antibiotic exposure.',
      sampleType: 'Stool / Blood',
      collectionDate: DateTime(2026, 8, 27),
      tests: [
        const LabTestResult(
          name: 'Stool culture',
          value: 'Salmonella species identified',
          status: LabStatus.completed,
          cost: 2900,
        ),
        const LabTestResult(
          name: 'LFT panel',
          value: 'Within normal limit',
          status: LabStatus.completed,
          cost: 1500,
        ),
      ],
      billAmount: 4400,
      dispatchedTo: ['Reception Desk'],
    ),
    PatientRecord(
      id: 'MB-2024-077',
      name: 'Ravi Iyer',
      age: 51,
      sex: 'Male',
      referredFrom: 'Orthopedic Ward',
      diagnosis: ['Post-surgical infection', 'Wound sepsis'],
      diseaseHistory: 'Recovering from orthopedic surgery; wound redness and discharge noted post-operation.',
      sampleType: 'Wound swab / Blood',
      collectionDate: DateTime(2026, 8, 28),
      tests: [
        const LabTestResult(
          name: 'Wound swab culture',
          value: 'Mixed flora; pending sensitivity',
          status: LabStatus.processing,
          cost: 2100,
        ),
        const LabTestResult(
          name: 'CRP',
          value: 'Elevated inflammatory marker',
          status: LabStatus.completed,
          cost: 1300,
        ),
      ],
      billAmount: 3400,
      dispatchedTo: ['Surgical Review Unit'],
    ),
    PatientRecord(
      id: 'MB-2024-088',
      name: 'Lakshmi Gupta',
      age: 42,
      sex: 'Female',
      referredFrom: 'Cardiology Unit',
      diagnosis: ['Infective endocarditis', 'Streptococcal infection'],
      diseaseHistory: 'History of heart murmur; recent fever and shortness of breath.',
      sampleType: 'Blood culture',
      collectionDate: DateTime(2026, 8, 29),
      tests: [
        const LabTestResult(
          name: 'Blood culture',
          value: 'Streptococcus viridans isolated',
          status: LabStatus.completed,
          cost: 3800,
        ),
        const LabTestResult(
          name: 'Echocardiography report',
          value: 'Vegetations noted',
          status: LabStatus.completed,
          cost: 2200,
        ),
      ],
      billAmount: 6000,
      dispatchedTo: ['Cardiology Unit'],
    ),
    PatientRecord(
      id: 'MB-2024-099',
      name: 'Vijay Kumar',
      age: 55,
      sex: 'Male',
      referredFrom: 'Infectious Diseases Unit',
      diagnosis: ['Tuberculosis', 'Pulmonary TB'],
      diseaseHistory: 'Chronic cough for 3 months; weight loss and night sweats.',
      sampleType: 'Sputum',
      collectionDate: DateTime(2026, 8, 30),
      tests: [
        const LabTestResult(
          name: 'Acid-fast bacilli (AFB)',
          value: 'Mycobacterium tuberculosis detected',
          status: LabStatus.completed,
          cost: 1500,
        ),
        const LabTestResult(
          name: 'TB culture',
          value: 'Pending drug susceptibility',
          status: LabStatus.processing,
          cost: 4500,
        ),
      ],
      billAmount: 6000,
      dispatchedTo: ['Infectious Diseases Unit'],
    ),
    PatientRecord(
      id: 'MB-2024-107',
      name: 'Anjali Patel',
      age: 31,
      sex: 'Female',
      referredFrom: 'Gynecology Clinic',
      diagnosis: ['Pelvic infection', 'Bacterial vaginosis'],
      diseaseHistory: 'Vaginal discharge and pelvic pain; recent unprotected contact.',
      sampleType: 'Vaginal swab',
      collectionDate: DateTime(2026, 8, 31),
      tests: [
        const LabTestResult(
          name: 'Gram stain',
          value: 'Clue cells and gram-negative bacteria',
          status: LabStatus.completed,
          cost: 1200,
        ),
        const LabTestResult(
          name: 'Bacterial culture',
          value: 'Mixed anaerobic flora',
          status: LabStatus.completed,
          cost: 2800,
        ),
      ],
      billAmount: 4000,
      dispatchedTo: ['Reception Desk'],
    ),
    PatientRecord(
      id: 'MB-2024-115',
      name: 'Karthik Menon',
      age: 38,
      sex: 'Male',
      referredFrom: 'Internal Medicine Ward',
      diagnosis: ['Meningitis', 'Bacterial meningitis'],
      diseaseHistory: 'High fever, severe headache, neck stiffness; rapid onset.',
      sampleType: 'CSF / Blood',
      collectionDate: DateTime(2026, 9, 1),
      tests: [
        const LabTestResult(
          name: 'CSF culture',
          value: 'Neisseria meningitidis isolated',
          status: LabStatus.completed,
          cost: 5000,
        ),
        const LabTestResult(
          name: 'Blood culture',
          value: 'Matching organism confirmed',
          status: LabStatus.completed,
          cost: 3600,
        ),
      ],
      billAmount: 8600,
      dispatchedTo: ['Reception Desk', 'ICU'],
    ),
    PatientRecord(
      id: 'MB-2024-122',
      name: 'Rekha Krishnan',
      age: 29,
      sex: 'Female',
      referredFrom: 'Pediatrics Department',
      diagnosis: ['Otitis media', 'Ear infection'],
      diseaseHistory: 'Ear pain and discharge in a 6-year-old child referred from pediatrics.',
      sampleType: 'Ear discharge',
      collectionDate: DateTime(2026, 9, 2),
      tests: [
        const LabTestResult(
          name: 'Gram stain',
          value: 'Pseudomonas aeruginosa',
          status: LabStatus.completed,
          cost: 800,
        ),
        const LabTestResult(
          name: 'Culture and sensitivity',
          value: 'Awaiting completion',
          status: LabStatus.processing,
          cost: 2400,
        ),
      ],
      billAmount: 3200,
      dispatchedTo: [],
    ),
    PatientRecord(
      id: 'MB-2024-135',
      name: 'Suresh Nair',
      age: 44,
      sex: 'Male',
      referredFrom: 'Oncology Department',
      diagnosis: ['Fungal infection', 'Invasive aspergillosis'],
      diseaseHistory: 'Immunocompromised patient with fever and respiratory symptoms; post-chemotherapy.',
      sampleType: 'BAL / Sputum',
      collectionDate: DateTime(2026, 8, 25),
      tests: [
        const LabTestResult(
          name: 'Aspergillus antigen',
          value: 'Galactomannan positive',
          status: LabStatus.completed,
          cost: 3200,
        ),
        const LabTestResult(
          name: 'Culture on Sabouraud',
          value: 'Awaiting growth',
          status: LabStatus.processing,
          cost: 2800,
        ),
      ],
      billAmount: 6000,
      dispatchedTo: [],
    ),
    PatientRecord(
      id: 'MB-2024-143',
      name: 'Divya Sundaram',
      age: 35,
      sex: 'Female',
      referredFrom: 'Hepatology Clinic',
      diagnosis: ['Hepatitis A', 'Acute viral hepatitis'],
      diseaseHistory: 'Jaundice, abdominal pain, and elevated liver enzymes; recent travel.',
      sampleType: 'Blood serum',
      collectionDate: DateTime(2026, 8, 26),
      tests: [
        const LabTestResult(
          name: 'Anti-HAV IgM',
          value: 'Positive',
          status: LabStatus.completed,
          cost: 1800,
        ),
        const LabTestResult(
          name: 'Liver function tests',
          value: 'ALT 450, AST 380, elevated',
          status: LabStatus.completed,
          cost: 1200,
        ),
      ],
      billAmount: 3000,
      dispatchedTo: [],
    ),
    PatientRecord(
      id: 'MB-2024-151',
      name: 'Ramesh Desai',
      age: 58,
      sex: 'Male',
      referredFrom: 'Nephrology Ward',
      diagnosis: ['Urinary tract infection', 'Pyelonephritis'],
      diseaseHistory: 'Fever, flank pain, dysuria; elevated creatinine levels.',
      sampleType: 'Urine culture',
      collectionDate: DateTime(2026, 8, 27),
      tests: [
        const LabTestResult(
          name: 'Urine culture',
          value: 'E. coli >100,000 CFU/ml',
          status: LabStatus.completed,
          cost: 1200,
        ),
        const LabTestResult(
          name: 'Antibiotic sensitivity',
          value: 'Fluoroquinolone resistant',
          status: LabStatus.completed,
          cost: 1400,
        ),
      ],
      billAmount: 2600,
      dispatchedTo: [],
    ),
    PatientRecord(
      id: 'MB-2024-162',
      name: 'Lavanya Dutta',
      age: 28,
      sex: 'Female',
      referredFrom: 'Dermatology Clinic',
      diagnosis: ['Fungal skin infection', 'Candida infection'],
      diseaseHistory: 'Persistent oral thrush unresponsive to topical antifungals.',
      sampleType: 'Oral swab / KOH mount',
      collectionDate: DateTime(2026, 8, 28),
      tests: [
        const LabTestResult(
          name: 'KOH mount',
          value: 'Pseudohyphae and budding yeast',
          status: LabStatus.completed,
          cost: 600,
        ),
        const LabTestResult(
          name: 'Candida culture',
          value: 'Awaiting species identification',
          status: LabStatus.processing,
          cost: 1800,
        ),
      ],
      billAmount: 2400,
      dispatchedTo: [],
    ),
    PatientRecord(
      id: 'MB-2024-173',
      name: 'Mukesh Rao',
      age: 52,
      sex: 'Male',
      referredFrom: 'ENT Department',
      diagnosis: ['Sinusitis', 'Chronic rhinosinusitis'],
      diseaseHistory: 'Chronic nasal congestion, facial pain, and purulent discharge.',
      sampleType: 'Nasal swab / Sinus aspirate',
      collectionDate: DateTime(2026, 8, 29),
      tests: [
        const LabTestResult(
          name: 'Gram stain',
          value: 'Polymorphonuclear leukocytes present',
          status: LabStatus.completed,
          cost: 600,
        ),
        const LabTestResult(
          name: 'Culture',
          value: 'Staphylococcus aureus and Streptococcus',
          status: LabStatus.completed,
          cost: 1600,
        ),
      ],
      billAmount: 2200,
      dispatchedTo: [],
    ),
    PatientRecord(
      id: 'MB-2024-184',
      name: 'Neha Verma',
      age: 33,
      sex: 'Female',
      referredFrom: 'Gastroenterology Clinic',
      diagnosis: ['Helicobacter pylori infection', 'Peptic ulcer disease'],
      diseaseHistory: 'Recurrent epigastric pain, nausea, and hematemesis.',
      sampleType: 'Gastric biopsy',
      collectionDate: DateTime(2026, 8, 30),
      tests: [
        const LabTestResult(
          name: 'Urea breath test',
          value: 'Positive for H. pylori',
          status: LabStatus.completed,
          cost: 2000,
        ),
        const LabTestResult(
          name: 'Histology with culture',
          value: 'Pending antibiotic susceptibility',
          status: LabStatus.processing,
          cost: 2200,
        ),
      ],
      billAmount: 4200,
      dispatchedTo: [],
    ),
    PatientRecord(
      id: 'MB-2024-195',
      name: 'Prakash Singh',
      age: 46,
      sex: 'Male',
      referredFrom: 'Neurology Unit',
      diagnosis: ['Bacterial meningitis', 'CNS infection'],
      diseaseHistory: 'Altered consciousness, fever, and neck rigidity; status post-viral illness.',
      sampleType: 'CSF',
      collectionDate: DateTime(2026, 8, 31),
      tests: [
        const LabTestResult(
          name: 'CSF analysis',
          value: 'Elevated protein, low glucose, pleocytosis',
          status: LabStatus.completed,
          cost: 1400,
        ),
        const LabTestResult(
          name: 'Gram stain and culture',
          value: 'Streptococcus pneumoniae isolated',
          status: LabStatus.completed,
          cost: 2400,
        ),
      ],
      billAmount: 3800,
      dispatchedTo: [],
    ),
    PatientRecord(
      id: 'MB-2024-206',
      name: 'Shreya Nambiar',
      age: 27,
      sex: 'Female',
      referredFrom: 'Rheumatology Clinic',
      diagnosis: ['Lyme disease', 'Borrelia infection'],
      diseaseHistory: 'Migratory arthralgia, myalgia, and recent tick exposure.',
      sampleType: 'Serum',
      collectionDate: DateTime(2026, 9, 1),
      tests: [
        const LabTestResult(
          name: 'Lyme serology (ELISA)',
          value: 'IgM positive',
          status: LabStatus.completed,
          cost: 1600,
        ),
        const LabTestResult(
          name: 'Confirmatory Western blot',
          value: 'Awaiting results',
          status: LabStatus.processing,
          cost: 2000,
        ),
      ],
      billAmount: 3600,
      dispatchedTo: [],
    ),
    PatientRecord(
      id: 'MB-2024-217',
      name: 'Praveen Chand',
      age: 50,
      sex: 'Male',
      referredFrom: 'Urology Department',
      diagnosis: ['Urinary tract infection', 'Prostatitis'],
      diseaseHistory: 'Dysuria, urinary frequency, and prostatic tenderness.',
      sampleType: 'Urine / Expressed prostatic secretion',
      collectionDate: DateTime(2026, 9, 2),
      tests: [
        const LabTestResult(
          name: 'Urine culture',
          value: 'Escherichia coli >100,000 CFU/ml',
          status: LabStatus.completed,
          cost: 1200,
        ),
        const LabTestResult(
          name: 'Sensitivity testing',
          value: 'Fluoroquinolone susceptible',
          status: LabStatus.completed,
          cost: 1400,
        ),
      ],
      billAmount: 2600,
      dispatchedTo: [],
    ),
  ];

  static DiseaseStatistics computeStats(List<PatientRecord> patients, {required DateTime from, required DateTime to}) {
    final Map<String, int> counts = {};
    for (final patient in patients) {
      if (patient.collectionDate.isAfter(from.subtract(const Duration(days: 1))) &&
          patient.collectionDate.isBefore(to.add(const Duration(days: 1)))) {
        for (final diagnosis in patient.diagnosis) {
          counts[diagnosis] = (counts[diagnosis] ?? 0) + 1;
        }
      }
    }
    return DiseaseStatistics(counts: counts, periodStart: from, periodEnd: to);
  }

  static DiseaseStatistics dailyStats(List<PatientRecord> patients, {required DateTime date}) {
    return computeStats(patients, from: date, to: date);
  }

  static DiseaseStatistics weeklyStats(List<PatientRecord> patients, {required DateTime date}) {
    final start = date.subtract(Duration(days: date.weekday - 1));
    final end = start.add(const Duration(days: 6));
    return computeStats(patients, from: start, to: end);
  }

  static DiseaseStatistics monthlyStats(List<PatientRecord> patients, {required DateTime date}) {
    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month + 1, 0);
    return computeStats(patients, from: start, to: end);
  }

  static DiseaseStatistics allTimeStats(List<PatientRecord> patients) {
    return computeStats(patients, from: DateTime(2000), to: DateTime.now().add(const Duration(days: 365)));
  }
}

class MicrobiologyDashboardPage extends StatefulWidget {
  const MicrobiologyDashboardPage({super.key});

  @override
  State<MicrobiologyDashboardPage> createState() => _MicrobiologyDashboardPageState();
}

class _MicrobiologyDashboardPageState extends State<MicrobiologyDashboardPage> {
  final List<PatientRecord> _patients = MockMicrobiologyData.patients;
  int _selectedIndex = 0;
  String _statsView = 'today'; // 'today', 'week', 'month', 'alltime'

  PatientRecord get _selectedPatient => _patients[_selectedIndex];

  DiseaseStatistics get _currentStats {
    final today = DateTime(2026, 9, 2);
    return switch (_statsView) {
      'today' => MockMicrobiologyData.dailyStats(_patients, date: today),
      'week' => MockMicrobiologyData.weeklyStats(_patients, date: today),
      'month' => MockMicrobiologyData.monthlyStats(_patients, date: today),
      'alltime' => MockMicrobiologyData.allTimeStats(_patients),
      _ => MockMicrobiologyData.allTimeStats(_patients),
    };
  }

  @override
  Widget build(BuildContext context) {
    final primaryBlue = const Color(0xFF0D47A1);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FF),
      appBar: AppBar(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Microbiology Unit'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final isWide = width >= 900;

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 340,
                      child: _PatientList(
                        patients: _patients,
                        selectedIndex: _selectedIndex,
                        onSelect: (index) => setState(() => _selectedIndex = index),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _PatientDetailCard(
                        patient: _selectedPatient,
                        onGenerateBill: () => _showBillDialog(context, _selectedPatient),
                        onDispatch: () => _showDispatchDialog(context, _selectedPatient),
                      ),
                    ),
                  ],
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: _PatientList(
                        patients: _patients,
                        selectedIndex: _selectedIndex,
                        onSelect: (index) => setState(() => _selectedIndex = index),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _PatientDetailCard(
                      patient: _selectedPatient,
                      onGenerateBill: () => _showBillDialog(context, _selectedPatient),
                      onDispatch: () => _showDispatchDialog(context, _selectedPatient),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiseaseStatisticsPage(patients: _patients),
            ),
          );
        },
        backgroundColor: const Color(0xFF0D47A1),
        tooltip: 'View statistics',
        child: const Icon(Icons.bar_chart_rounded, color: Colors.white),
      ),
    );
  }

  void _showBillDialog(BuildContext context, PatientRecord patient) {
    final billLines = patient.tests.map((test) => '${test.name}: ${_formatMoney(test.cost)}').join('\n');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invoice for ${patient.id}'),
        content: SizedBox(
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Patient: ${patient.name}', style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text('Age: ${patient.age} | Sex: ${patient.sex}'),
              const SizedBox(height: 12),
              Text('Tests billed:\n$billLines'),
              const SizedBox(height: 12),
              const Divider(),
              Text('Total: ${_formatMoney(patient.billAmount)}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showDispatchDialog(BuildContext context, PatientRecord patient) {
    final departments = ['Reception Desk', 'Emergency Department', 'Infectious Diseases Unit', 'Cardiology Unit', 'Pulmonology Unit'];

    showDialog(
      context: context,
      builder: (context) {
        String selectedDepartment = patient.dispatchedTo.isNotEmpty ? patient.dispatchedTo.first : departments.first;

        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Dispatch results'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Select the department to receive the final microbiology report:'),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: selectedDepartment,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: departments
                      .map((dept) => DropdownMenuItem(value: dept, child: Text(dept)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedDepartment = value ?? selectedDepartment),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  if (!patient.dispatchedTo.contains(selectedDepartment)) {
                    patient.dispatchedTo.add(selectedDepartment);
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Results sent to $selectedDepartment for ${patient.name}'),
                    ),
                  );
                },
                child: const Text('Send'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DiseaseStatisticsPage extends StatefulWidget {
  final List<PatientRecord> patients;

  const DiseaseStatisticsPage({required this.patients, super.key});

  @override
  State<DiseaseStatisticsPage> createState() => _DiseaseStatisticsPageState();
}

class _DiseaseStatisticsPageState extends State<DiseaseStatisticsPage> {
  String _statsView = 'today';

  DiseaseStatistics get _currentStats {
    final today = DateTime(2026, 9, 2);
    return switch (_statsView) {
      'today' => MockMicrobiologyData.dailyStats(widget.patients, date: today),
      'week' => MockMicrobiologyData.weeklyStats(widget.patients, date: today),
      'month' => MockMicrobiologyData.monthlyStats(widget.patients, date: today),
      'alltime' => MockMicrobiologyData.allTimeStats(widget.patients),
      _ => MockMicrobiologyData.allTimeStats(widget.patients),
    };
  }

  @override
  Widget build(BuildContext context) {
    final primaryBlue = const Color(0xFF0D47A1);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FF),
      appBar: AppBar(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Disease Statistics'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: _StatisticsPanel(
              stats: _currentStats,
              currentView: _statsView,
              onViewChanged: (view) => setState(() => _statsView = view),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatisticsPanel extends StatelessWidget {
  final DiseaseStatistics stats;
  final String currentView;
  final ValueChanged<String> onViewChanged;

  const _StatisticsPanel({
    required this.stats,
    required this.currentView,
    required this.onViewChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 800;
                return isNarrow
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Disease Statistics', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: ['today', 'week', 'month', 'alltime']
                                .map(
                                  (view) => ElevatedButton(
                                    onPressed: () => onViewChanged(view),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: currentView == view ? const Color(0xFF0D47A1) : const Color(0xFFF0F6FF),
                                      foregroundColor: currentView == view ? Colors.white : const Color(0xFF0D47A1),
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    child: Text(view.toUpperCase(), style: const TextStyle(fontSize: 11)),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Disease Statistics', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
                          Row(
                            spacing: 8,
                            children: ['today', 'week', 'month', 'alltime']
                                .map(
                                  (view) => ElevatedButton(
                                    onPressed: () => onViewChanged(view),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: currentView == view ? const Color(0xFF0D47A1) : const Color(0xFFF0F6FF),
                                      foregroundColor: currentView == view ? Colors.white : const Color(0xFF0D47A1),
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    child: Text(view.toUpperCase()),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatsBox(
                  label: 'Total Cases',
                  value: stats.totalCases.toString(),
                  color: const Color(0xFF0D47A1),
                ),
                _StatsBox(
                  label: 'Top Disease',
                  value: stats.topDisease,
                  color: const Color(0xFFEF6C00),
                ),
                _StatsBox(
                  label: 'Unique Diseases',
                  value: stats.counts.length.toString(),
                  color: const Color(0xFF2E7D32),
                ),
              ],
            ),
            if (stats.counts.isNotEmpty) ...[  
              const SizedBox(height: 20),
              const Text('Disease Breakdown', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: stats.counts.entries
                    .map(
                      (entry) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F6FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${entry.key}: ${entry.value}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0D47A1)),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatsBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatsBox({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: color)),
      ],
    );
  }
}

class _PatientList extends StatelessWidget {
  final List<PatientRecord> patients;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _PatientList({required this.patients, required this.selectedIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Patient list', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                final isSelected = index == selectedIndex;

                return InkWell(
                  onTap: () => onSelect(index),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFEAF2FF) : const Color(0xFFF9FBFF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? const Color(0xFFBAD0FF) : Colors.transparent,
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(patient.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                              const SizedBox(height: 4),
                              Text('${patient.id} • Age ${patient.age}', style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 12)),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: patient.diagnosis
                                    .map((item) => Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFDDEBFF),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(item, style: const TextStyle(fontSize: 11)),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        _StatusChip(status: patient.statusLabel),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientDetailCard extends StatelessWidget {
  final PatientRecord patient;
  final VoidCallback onGenerateBill;
  final VoidCallback onDispatch;

  const _PatientDetailCard({
    required this.patient,
    required this.onGenerateBill,
    required this.onDispatch,
  });

  @override
  Widget build(BuildContext context) {
    final primaryBlue = const Color(0xFF0D47A1);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(patient.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 28)),
                      const SizedBox(height: 6),
                      Text('Unique ID: ${patient.id}', style: TextStyle(color: Colors.blueGrey.shade700)),
                    ],
                  ),
                ),
                _StatusChip(status: patient.statusLabel),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F3FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.call_split_rounded, color: Color(0xFF0D47A1)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Referred from: ${patient.referredFrom}',
                      style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0D47A1)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _InfoPill(label: 'Age', value: '${patient.age} years'),
                _InfoPill(label: 'Sex', value: patient.sex),
                _InfoPill(label: 'Sample', value: patient.sampleType),
                _InfoPill(label: 'Collected', value: patient.collectionDate.toString().split(' ')[0]),
              ],
            ),
            const SizedBox(height: 26),
            const Text('Diagnosis', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: patient.diagnosis
                  .map((item) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F3FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(item, style: const TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.w600)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 26),
            const Text('Disease history', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text(patient.diseaseHistory, style: TextStyle(fontSize: 15, height: 1.6, color: Colors.blueGrey.shade700)),
            const SizedBox(height: 28),
            const Text('Lab test results', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 12),
            ...patient.tests.map((test) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2EDFF)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(test.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 6),
                            Text(test.value, style: TextStyle(color: Colors.blueGrey.shade700)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      _LabStatusBadge(status: test.status),
                    ],
                  ),
                )),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F9FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE1ECFF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Dispatch / referral status', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 8),
                  if (patient.dispatchedTo.isEmpty)
                    const Text('No referral dispatched yet.')
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: patient.dispatchedTo
                          .map((dept) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDDEBFF),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(dept, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                              ))
                          .toList(),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onDispatch,
                icon: const Icon(Icons.send_rounded),
                label: const Text('Send completed results to reception'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onGenerateBill,
                icon: const Icon(Icons.receipt_long_outlined),
                label: const Text('Generate bill'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final String label;
  final String value;

  const _InfoPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F6FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label: ', style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
          Text(value, style: const TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'Completed' => const Color(0xFF2E7D32),
      'Processing' => const Color(0xFFEF6C00),
      _ => const Color(0xFF546E7A),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(status, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color)),
    );
  }
}

class _LabStatusBadge extends StatelessWidget {
  final LabStatus status;

  const _LabStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      LabStatus.completed => 'Completed',
      LabStatus.processing => 'Processing',
      LabStatus.pending => 'Pending',
    };

    final color = switch (status) {
      LabStatus.completed => const Color(0xFF2E7D32),
      LabStatus.processing => const Color(0xFFEF6C00),
      LabStatus.pending => const Color(0xFF546E7A),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color)),
    );
  }
}

String _formatMoney(double amount) => 'KSh ${amount.toStringAsFixed(0)}';
