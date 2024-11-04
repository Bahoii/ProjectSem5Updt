import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizz/page/provider/providerScore.dart';
import 'package:share_plus/share_plus.dart';

class QuizPage extends StatefulWidget {
  final String quizType;
  final String title;

  const QuizPage(this.quizType, this.title, {super.key});
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<Map<String, Object>> _questions = [];
  final Map<int, String> _selectedAnswers = {};

  final String downloadLink = "https://UPPSKILL.com";

  void _shareLink() async {
    try {
      String message = 'Download our app using this link: $downloadLink';
      await Share.share(message);
    } catch (error) {
      print('Error sharing link: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing link: $error')),
      );
    }
  }

  void _copyLink() {
    Clipboard.setData(ClipboardData(text: downloadLink));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download link copied to clipboard!')),
    );
  }

  final List<Map<String, Object>> _questions1 = [
    //dinamika
    {
      'question':
          'Jika gaya sebesar 50 N diberikan pada benda bermassa 10 kg, berapa percepatan yang dihasilkan? ',
      'answers': ['2 m/s²', '4 m/s²', '5 m/s²', '10 m/s²'],
      'correctAnswer': '5 m/s²',
      'theme': {'color': Colors.blue, 'icon': Icons.code},
    },
    {
      'question':
          'Sebuah benda bermassa 8 kg bergerak dengan percepatan 3 m/s². Berapa gaya yang bekerja pada benda tersebut?',
      'answers': ['16 N', '24 N', '32 N', '40 N'],
      'correctAnswer': '24 N',
      'theme': {'color': Colors.green, 'icon': Icons.person},
    },
    {
      'question':
          'Sebuah kotak dengan massa 5 kg di atas permukaan mendatar ditarik dengan gaya 30 N sehingga mengalami percepatan. Jika gaya gesek yang terjadi sebesar 10 N, berapa percepatan benda?',
      'answers': ['2 m/s²', '4 m/s²', '5 m/s²', '6 m/s²'],
      'correctAnswer': '2 m/s²',
      'theme': {'color': Colors.orange, 'icon': Icons.list},
    },
    {
      'question':
          'Sebuah benda bermassa 2 kg digerakkan dengan gaya konstan di atas bidang datar licin. Jika benda bergerak dengan percepatan 3 m/s², berapa besar gaya yang diberikan pada benda?',
      'answers': ['5 N', '6 N', '9 N', '12 N'],
      'correctAnswer': '6 N',
      'theme': {'color': Colors.red, 'icon': Icons.functions},
    },
    {
      'question':
          'Sebuah benda bermassa 8 kg bergerak dengan percepatan 3 m/s². Berapa gaya yang bekerja pada benda tersebut?',
      'answers': ['16 N', '24 N', '32 N', '40 N'],
      'correctAnswer': '24 N',
      'theme': {'color': Colors.purple, 'icon': Icons.comment},
    },
  ];

  final List<Map<String, Object>> _questions2 = [
    //kinematika
    {
      'question':
          'Sebuah mobil bergerak dengan kecepatan konstan 30 m/s selama 5 detik. Berapa jarak yang ditempuh? ',
      'answers': ['120 meter', '150 meter', '180 meter', '210 meter'],
      'correctAnswer': '150 meter',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'Sebuah benda bergerak dipercepat dari keadaan diam hingga mencapai kecepatan 25 m/s dalam waktu 5 detik. Berapa percepatan benda tersebut?',
      'answers': ['5 m/s²', '10 m/s²', '15 m/s²', '25 m/s²'],
      'correctAnswer': '5 m/s²',
      'theme': {'color': Colors.green},
    },
    {
      'question':
          'Sebuah kereta melaju dengan kecepatan 60 km/jam selama 2 jam. Berapa jarak yang ditempuh kereta tersebut?',
      'answers': ['60 km', '100 km', '120 km', '180 km'],
      'correctAnswer': '120 km',
      'theme': {'color': Colors.orange},
    },
    {
      'question':
          'Sebuah benda bergerak dengan kecepatan awal 10 m/s dan dipercepat dengan percepatan 2 m/s² selama 4 detik. Berapa kecepatan akhirnya?',
      'answers': ['12 m/s', '16 m/s', '18 m/s', '20 m/s'],
      'correctAnswer': '20 m/s',
      'theme': {'color': Colors.red},
    },
    {
      'question':
          'Sebuah mobil bergerak dengan kecepatan konstan 30 m/s selama 5 detik. Berapa jarak yang ditempuh?',
      'answers': ['120 meter', '150 meter', '180 meter', '210 meter'],
      'correctAnswer': '150 meter',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions3 = [
    //Termodinamika
    {
      'question':
          'Suatu gas ideal dipanaskan sehingga volumenya meningkat pada tekanan tetap. Apa yang akan terjadi pada suhu gas tersebut?',
      'answers': ['Berkurang', 'Tetap', 'Bertambah', 'Tidak berubah'],
      'correctAnswer': 'Bertambah',
      'theme': {'color': Colors.green},
    },
    {
      'question':
          'Proses termodinamika dimana tidak ada perpindahan panas ke atau dari sistem disebut:',
      'answers': ['Isobarik', 'Isotermik', 'Adiabatik', 'Isokhorik'],
      'correctAnswer': 'Adiabatik',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'Jika 500 J energi panas diberikan ke dalam sistem yang melakukan kerja sebesar 200 J, berapa perubahan energi dalam sistem tersebut?',
      'answers': ['200 J', '300 J', '500 J', '700 J'],
      'correctAnswer': '300 J',
      'theme': {'color': Colors.orange},
    },
    {
      'question':
          'Pada sebuah mesin Carnot, efisiensi maksimum diperoleh jika:',
      'answers': [
        'Suhu reservoir panas sangat tinggi',
        'Suhu reservoir dingin lebih tinggi dari suhu reservoir panas',
        'Suhu reservoir dingin sangat rendah',
        'Suhu reservoir panas dan dingin sama'
      ],
      'correctAnswer': 'Suhu reservoir dingin sangat rendah',
      'theme': {'color': Colors.purple},
    },
    {
      'question': 'Hukum kedua termodinamika menyatakan bahwa:',
      'answers': [
        'Energi tidak dapat diciptakan atau dimusnahkan',
        'Entropi alam semesta selalu bertambah',
        'Suhu benda tidak pernah bisa mencapai nol absolut',
        'Tekanan gas ideal berbanding lurus dengan suhunya'
      ],
      'correctAnswer': 'Entropi alam semesta selalu bertambah',
      'theme': {'color': Colors.red},
    },
  ];

  final List<Map<String, Object>> _questions4 = [
    //Listrik dan magnet
    {
      'question':
          'Berapa kuat arus yang mengalir pada rangkaian jika beda potensialnya 12 V dan hambatannya 4 ohm?',
      'answers': ['2 A', '3 A', '4 A', '6 A'],
      'correctAnswer': '3 A',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'Sebuah kawat dialiri arus listrik sebesar 5 A selama 2 detik. Berapa besar muatan yang mengalir melalui kawat tersebut?',
      'answers': ['5 C', '7 C', '8 C', '10 C'],
      'correctAnswer': '10 C',
      'theme': {'color': Colors.green},
    },
    {
      'question':
          'Sebuah resistor memiliki hambatan 10 ohm dan dialiri arus 2 A. Berapa daya listrik yang dipakai resistor tersebut?',
      'answers': ['20 W', '30 W', '40 W', '50 W'],
      'correctAnswer': '40 W',
      'theme': {'color': Colors.orange},
    },
    {
      'question':
          'Jika dua muatan positif didekatkan satu sama lain, apa yang akan terjadi?',
      'answers': [
        'Keduanya akan saling tarik-menarik',
        'Keduanya akan saling tolak-menolak',
        'Salah satu akan tetap diam',
        'Tidak ada gaya yang bekerja'
      ],
      'correctAnswer': 'Keduanya akan saling tolak-menolak',
      'theme': {'color': Colors.red},
    },
    {
      'question':
          'Hukum Faraday tentang induksi elektromagnetik menyatakan bahwa:',
      'answers': [
        'Arus listrik dapat mengalir tanpa medan magnet',
        'Perubahan medan magnet dalam suatu rangkaian menghasilkan arus listrik',
        'Medan magnet tidak mempengaruhi arus listrik',
        'Gaya magnetik hanya bekerja pada benda diam'
      ],
      'correctAnswer':
          'Perubahan medan magnet dalam suatu rangkaian menghasilkan arus listrik',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions5 = [
    //Optik
    {
      'question':
          'Sebuah cermin cekung memiliki jarak fokus 20 cm. Jika sebuah benda diletakkan 60 cm dari cermin, berapa jarak bayangan yang terbentuk?',
      'answers': ['15 cm', '30 cm', '40 cm', '60 cm'],
      'correctAnswer': '30 cm',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'Sebuah sinar datang dengan sudut 30 derajat terhadap normal pada permukaan air. Berapa sudut bias yang terbentuk jika indeks bias air adalah 1,33?',
      'answers': ['18,6°', '22,1°', '24,6°', '27,5°'],
      'correctAnswer': '22,1°',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'Apa yang terjadi pada sinar yang melewati lensa cembung?',
      'answers': [
        'Sinar menyebar',
        'Sinar menyatu di titik fokus',
        'Sinar tidak berubah',
        'Sinar memantul'
      ],
      'correctAnswer': 'Sinar menyatu di titik fokus',
      'theme': {'color': Colors.orange},
    },
    {
      'question':
          'Sebuah prisma dengan indeks bias 1,5 ditembus oleh cahaya putih. Apa yang terjadi pada cahaya saat keluar dari prisma?',
      'answers': [
        'Cahaya tetap putih',
        'Cahaya terurai menjadi spektrum warna',
        'Cahaya menjadi lebih terang',
        'Cahaya dipantulkan sepenuhnya'
      ],
      'correctAnswer': 'Cahaya terurai menjadi spektrum warna',
      'theme': {'color': Colors.red},
    },
    {
      'question':
          'Hukum pemantulan menyatakan bahwa sudut datang sama dengan sudut:',
      'answers': ['Bias', 'Pembiasan', 'Refleksi', 'Difraksi'],
      'correctAnswer': 'Refleksi',
      'theme': {'color': Colors.purple},
    },
  ];
  //matematika
  final List<Map<String, Object>> _questions6 = [
    {
      'question': 'What is the value of x in the equation: 3x + 5 = 17?',
      'answers': ['4', '6', '7', '8'],
      'correctAnswer': '4',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'What is the result of the expression: 2x^2 + 3x - 5 when x = 2?',
      'answers': ['9', '10', '11', '12'],
      'correctAnswer': '12',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'Solve for x: 2(x + 3) = 14',
      'answers': ['5', '6', '7', '8'],
      'correctAnswer': '5',
      'theme': {'color': Colors.orange},
    },
    {
      'question': 'What is the value of y in the equation: 4y - 7 = 25?',
      'answers': ['8', '9', '10', '11'],
      'correctAnswer': '8',
      'theme': {'color': Colors.red},
    },
    {
      'question': 'Solve for x: 3x - 2 = 13',
      'answers': ['3', '5', '6', '7'],
      'correctAnswer': '5',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions7 = [
    {
      'question': 'What is the slope of the line with equation y = 3x + 2?',
      'answers': ['3', '2', '-3', '-2'],
      'correctAnswer': '3',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'What is the y-intercept of the line with equation y = -2x + 5?',
      'answers': ['2', '5', '-2', '-5'],
      'correctAnswer': '5',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'Which of the following lines has a slope of 0?',
      'answers': ['y = 2x + 3', 'y = -3', 'x = 5', 'y = -4x'],
      'correctAnswer': 'y = -3',
      'theme': {'color': Colors.orange},
    },
    {
      'question': 'What is the slope of a horizontal line?',
      'answers': ['0', '1', 'Undefined', 'Infinity'],
      'correctAnswer': '0',
      'theme': {'color': Colors.red},
    },
    {
      'question': 'What is the slope of a vertical line?',
      'answers': ['0', '1', 'Undefined', 'Infinity'],
      'correctAnswer': 'Undefined',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions8 = [
    {
      'question': 'What is the formula for the volume of a cube?',
      'answers': ['V = s^2', 'V = l * w * h', 'V = πr^2', 'V = 4/3πr^3'],
      'correctAnswer': 'V = s^2',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'What is the surface area of a rectangular prism with length 4 cm, width 3 cm, and height 2 cm?',
      'answers': ['20 cm^2', '28 cm^2', '36 cm^2', '48 cm^2'],
      'correctAnswer': '28 cm^2',
      'theme': {'color': Colors.green},
    },
    {
      'question':
          'What is the volume of a cylinder with radius 5 cm and height 10 cm?',
      'answers': ['50π cm^3', '100π cm^3', '125π cm^3', '250π cm^3'],
      'correctAnswer': '250π cm^3',
      'theme': {'color': Colors.orange},
    },
    {
      'question': 'What is the surface area of a sphere with radius 7 cm?',
      'answers': ['98π cm^2', '154π cm^2', '196π cm^2', '392π cm^2'],
      'correctAnswer': '196π cm^2',
      'theme': {'color': Colors.red},
    },
    {
      'question':
          'What is the volume of a triangular prism with base 8 cm, height 10 cm, and prism height 15 cm?',
      'answers': ['160 cm^3', '240 cm^3', '320 cm^3', '400 cm^3'],
      'correctAnswer': '240 cm^3',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions9 = [
    {
      'question': 'What is another term for regression line?',
      'answers': [
        'Trend line',
        'Control line',
        'Fractal line',
        'Coherent line'
      ],
      'correctAnswer': 'Trend line',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'In regression analysis, what is done by the regression coefficient?',
      'answers': [
        'Measures the strength of relationship',
        'Measures the slope of the regression line',
        'Measures the curvature of the data',
        'Measures the concentration of the data'
      ],
      'correctAnswer': 'Measures the slope of the regression line',
      'theme': {'color': Colors.green},
    },
    {
      'question':
          'What does the coefficient of determination (R^2) indicate in regression analysis?',
      'answers': [
        'Percentage of variation explained by the model',
        'Number of observations in the sample',
        'Significance level of the model',
        'Accuracy of the model predictions'
      ],
      'correctAnswer': 'Percentage of variation explained by the model',
      'theme': {'color': Colors.orange},
    },
    {
      'question':
          'What does the correlation coefficient indicate in linear regression analysis?',
      'answers': [
        'Strength and direction of relationship between variables',
        'Slope of the regression line',
        'Percentage of variation explained by the model',
        'Accuracy of the model predictions'
      ],
      'correctAnswer':
          'Strength and direction of relationship between variables',
      'theme': {'color': Colors.red},
    },
    {
      'question': 'What does the p-value indicate in regression analysis?',
      'answers': [
        'Significance of the predictor variables',
        'Accuracy of the regression model',
        'Strength of the relationship between variables',
        'Variability of the residuals'
      ],
      'correctAnswer': 'Significance of the predictor variables',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions10 = [
    {
      'question': 'What is the formula for calculating the area of a triangle?',
      'answers': [
        'A = 1/2 * base * height',
        'A = π * r^2',
        'A = length * width',
        'A = s^2'
      ],
      'correctAnswer': 'A = 1/2 * base * height',
      'theme': {'color': Colors.blue},
    },
    {
      'question': 'What is the Pythagorean theorem?',
      'answers': [
        'a^2 + b^2 = c^2',
        'a^2 + b^2 = d^2',
        'a + b = c',
        'a + b + c = 180'
      ],
      'correctAnswer': 'a^2 + b^2 = c^2',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'What is the formula for calculating the volume of a cone?',
      'answers': [
        'V = 1/3 * π * r^2 * h',
        'V = l * w * h',
        'V = s^2',
        'V = 4/3 * π * r^3'
      ],
      'correctAnswer': 'V = 1/3 * π * r^2 * h',
      'theme': {'color': Colors.orange},
    },
    {
      'question':
          'What is the formula for calculating the circumference of a circle?',
      'answers': [
        'C = 2 * π * r',
        'C = π * d',
        'C = 4 * π * r',
        'C = 1/2 * π * r^2'
      ],
      'correctAnswer': 'C = 2 * π * r',
      'theme': {'color': Colors.red},
    },
    {
      'question':
          'What is the formula for calculating the surface area of a sphere?',
      'answers': [
        'A = 4 * π * r^2',
        'A = 2 * π * r',
        'A = π * r^2',
        'A = 1/3 * π * r^2 * h'
      ],
      'correctAnswer': 'A = 4 * π * r^2',
      'theme': {'color': Colors.purple},
    },
  ];

  //kimia

  final List<Map<String, Object>> _questions11 = [
    // Stoikiometri
    {
      'question':
          'Berapa mol air yang dihasilkan dari pembakaran 2 mol hidrogen dengan oksigen berlebih? (Reaksi: 2H₂ + O₂ → 2H₂O)',
      'answers': ['1 mol', '2 mol', '3 mol', '4 mol'],
      'correctAnswer': '2 mol',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'Berapa massa (gram) NaCl yang diperlukan untuk menghasilkan 2 mol NaCl? (Ar Na = 23, Ar Cl = 35,5)',
      'answers': ['58,5 g', '117 g', '150 g', '200 g'],
      'correctAnswer': '117 g',
      'theme': {'color': Colors.green},
    },
    {
      'question':
          'Jika 4 mol H₂ bereaksi dengan 2 mol O₂, berapa mol air yang terbentuk? (Reaksi: 2H₂ + O₂ → 2H₂O)',
      'answers': ['1 mol', '2 mol', '4 mol', '6 mol'],
      'correctAnswer': '4 mol',
      'theme': {'color': Colors.orange},
    },
    {
      'question':
          'Berapa volume gas CO₂ yang dihasilkan dari pembakaran sempurna 5 mol C₂H₆ pada suhu dan tekanan standar? (Reaksi: 2C₂H₆ + 7O₂ → 4CO₂ + 6H₂O)',
      'answers': ['11,2 L', '22,4 L', '56,0 L', '112,0 L'],
      'correctAnswer': '112,0 L',
      'theme': {'color': Colors.red},
    },
    {
      'question':
          'Berapa gram CO₂ yang dihasilkan dari pembakaran sempurna 44 gram CH₄? (Mr CH₄ = 16 g/mol, Mr CO₂ = 44 g/mol)',
      'answers': ['22 g', '44 g', '88 g', '132 g'],
      'correctAnswer': '88 g',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions12 = [
    //struktur atom
    {
      'question': 'Elektron pada kulit terluar suatu atom disebut:',
      'answers': [
        'Elektron inti',
        'Elektron valensi',
        'Elektron terionisasi',
        'Elektron bebas'
      ],
      'correctAnswer': 'Elektron valensi',
      'theme': {'color': Colors.blue},
    },
    {
      'question': 'Model atom Bohr menyatakan bahwa:',
      'answers': [
        'Elektron bergerak dalam orbit berbentuk spiral',
        'Elektron bergerak di orbit stasioner',
        'Elektron berotasi mengelilingi proton',
        'Elektron memiliki massa yang sama dengan proton'
      ],
      'correctAnswer': 'Elektron bergerak di orbit stasioner',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'Berapa jumlah proton dalam atom oksigen (nomor atom 8)?',
      'answers': ['6', '7', '8', '10'],
      'correctAnswer': '8',
      'theme': {'color': Colors.orange},
    },
    {
      'question': 'Orbital yang memiliki bentuk sferis adalah:',
      'answers': ['Orbital s', 'Orbital p', 'Orbital d', 'Orbital f'],
      'correctAnswer': 'Orbital s',
      'theme': {'color': Colors.red},
    },
    {
      'question':
          'Atom yang memiliki konfigurasi elektron 1s² 2s² 2p⁶ 3s² 3p³ adalah:',
      'answers': ['Natrium (Na)', 'Fosfor (P)', 'Sulfur (S)', 'Klorin (Cl)'],
      'correctAnswer': 'Fosfor (P)',
      'theme': {'color': Colors.purple},
    },
  ];

  //termokimia

  final List<Map<String, Object>> _questions13 = [
    {
      'question': 'Reaksi yang melepaskan panas ke lingkungan disebut:',
      'answers': ['Endoterm', 'Eksoterm', 'Isoterm', 'Adiabatik'],
      'correctAnswer': 'Eksoterm',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'Berapa besar perubahan entalpi jika 50 kJ panas diserap oleh sistem pada tekanan konstan?',
      'answers': ['-50 kJ', '0 kJ', '25 kJ', '50 kJ'],
      'correctAnswer': '50 kJ',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'Hukum Hess menyatakan bahwa:',
      'answers': [
        'Entalpi hanya bergantung pada jalur reaksi',
        'Entalpi perubahan reaksi sama untuk setiap jalur',
        'Entalpi hanya bergantung pada tekanan dan suhu',
        'Energi total sistem selalu tetap'
      ],
      'correctAnswer': 'Entalpi perubahan reaksi sama untuk setiap jalur',
      'theme': {'color': Colors.orange},
    },
    {
      'question':
          'Dalam reaksi endoterm, apa yang terjadi pada suhu lingkungan?',
      'answers': ['Suhu naik', 'Suhu turun', 'Suhu tetap', 'Suhu berfluktuasi'],
      'correctAnswer': 'Suhu turun',
      'theme': {'color': Colors.red},
    },
    {
      'question':
          'Jika perubahan entalpi reaksi eksoterm adalah -100 kJ/mol, berapa energi yang dilepaskan ketika 2 mol zat bereaksi?',
      'answers': ['50 kJ', '100 kJ', '150 kJ', '200 kJ'],
      'correctAnswer': '200 kJ',
      'theme': {'color': Colors.purple},
    },
  ];

  //reaksi kimia

  final List<Map<String, Object>> _questions14 = [
    {
      'question':
          'Berapa koefisien dari H₂ dalam reaksi berikut setelah disetarakan? Al + H₂SO₄ → Al₂(SO₄)₃ + H₂',
      'answers': ['2', '3', '6', '4'],
      'correctAnswer': '3',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'Dalam reaksi pembakaran sempurna hidrokarbon, produk utamanya adalah:',
      'answers': ['CO₂ dan H₂O', 'CO dan H₂O', 'CO₂ dan O₂', 'CO dan H₂'],
      'correctAnswer': 'CO₂ dan H₂O',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'Zat yang mempercepat reaksi tanpa ikut bereaksi disebut:',
      'answers': ['Reaktan', 'Produk', 'Katalis', 'Inhibitor'],
      'correctAnswer': 'Katalis',
      'theme': {'color': Colors.orange},
    },
    {
      'question': 'Reaksi antara HCl dan NaOH menghasilkan:',
      'answers': ['NaCl dan H₂', 'NaOH dan H₂O', 'NaCl dan H₂O', 'H₂O dan O₂'],
      'correctAnswer': 'NaCl dan H₂O',
      'theme': {'color': Colors.red},
    },
    {
      'question':
          'Reaksi penggabungan dua zat untuk membentuk zat baru disebut:',
      'answers': [
        'Reaksi penguraian',
        'Reaksi sintesis',
        'Reaksi oksidasi',
        'Reaksi perpindahan'
      ],
      'correctAnswer': 'Reaksi sintesis',
      'theme': {'color': Colors.purple},
    },
  ];
  //kimia organik

  final List<Map<String, Object>> _questions15 = [
    {
      'question':
          'Alkana adalah senyawa hidrokarbon jenuh yang memiliki rumus umum',
      'answers': ['CnH₂n', 'CnH₂n₊₂', 'CnH₂n₋₂', 'CnHn'],
      'correctAnswer': 'CnH₂n₊₂',
      'theme': {'color': Colors.blue},
    },
    {
      'question': 'Senyawa yang termasuk golongan alkohol adalah:',
      'answers': ['CH₃CH₂OH', 'CH₄', 'C₆H₆', 'CH₃COOH'],
      'correctAnswer': 'CH₃CH₂OH',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'Reaksi adisi hidrogen pada alkena menghasilkan:',
      'answers': ['Alkana', 'Alkohol', 'Alkena', 'Alkil halida'],
      'correctAnswer': 'Alkana',
      'theme': {'color': Colors.orange},
    },
    {
      'question': 'Nama senyawa organik CH₃CH₂CH₃ adalah:',
      'answers': ['Butana', 'Propana', 'Etena', 'Metana'],
      'correctAnswer': 'Propana',
      'theme': {'color': Colors.red},
    },
    {
      'question': 'Gugus fungsi dari senyawa aldehid adalah:',
      'answers': ['-OH', '-COOH', '-CHO', '-NH₂'],
      'correctAnswer': '-CHO',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions16 = [
    {
      'question': 'What is the formula to calculate the area of a rectangle?',
      'answers': [
        'A = l * w',
        'A = s^2',
        'A = πr^2',
        'A = 1/2 * base * height'
      ],
      'correctAnswer': 'A = l * w',
      'theme': {'color': Colors.blue},
    },
    {
      'question':
          'What is the formula for calculating the perimeter of a square?',
      'answers': ['P = 4s', 'P = l + w + h', 'P = 2πr', 'P = s^2'],
      'correctAnswer': 'P = 4s',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'What is the formula to find the volume of a cylinder?',
      'answers': ['V = πr^2 * h', 'V = l * w * h', 'V = s^2', 'V = 4/3πr^3'],
      'correctAnswer': 'V = πr^2 * h',
      'theme': {'color': Colors.orange},
    },
    {
      'question':
          'What is the formula to calculate the circumference of a circle?',
      'answers': ['C = 2πr', 'C = l + w + h', 'C = πr^2', 'C = s^2'],
      'correctAnswer': 'C = 2πr',
      'theme': {'color': Colors.red},
    },
    {
      'question':
          'What is the formula for finding the surface area of a rectangular prism?',
      'answers': [
        'A = 2lw + 2lh + 2wh',
        'A = l * w',
        'A = πr^2',
        'A = 1/2 * base * height'
      ],
      'correctAnswer': 'A = 2lw + 2lh + 2wh',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions17 = [
    {
      'question': 'What is the formula for calculating compound interest?',
      'answers': [
        'A = P(1 + r/n)^(nt)',
        'A = P * r * t',
        'A = P * (1 + r)^t',
        'A = P + rt'
      ],
      'correctAnswer': 'A = P(1 + r/n)^(nt)',
      'theme': {'color': Colors.blue},
    },
    {
      'question': 'What is the Pythagorean theorem in 3D?',
      'answers': [
        'c^2 = a^2 + b^2',
        'c = √(a^2 + b^2)',
        'a^2 + b^2 = d^2',
        'a + b = c'
      ],
      'correctAnswer': 'c^2 = a^2 + b^2',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'What is the formula for the volume of a cone?',
      'answers': [
        'V = 1/3 * π * r^2 * h',
        'V = l * w * h',
        'V = s^2',
        'V = 4/3 * π * r^3'
      ],
      'correctAnswer': 'V = 1/3 * π * r^2 * h',
      'theme': {'color': Colors.orange},
    },
    {
      'question':
          'What is the formula for calculating the area of a trapezoid?',
      'answers': [
        'A = 1/2 * (b1 + b2) * h',
        'A = l * w',
        'A = πr^2',
        'A = 1/2 * base * height'
      ],
      'correctAnswer': 'A = 1/2 * (b1 + b2) * h',
      'theme': {'color': Colors.red},
    },
    {
      'question': 'What is the formula for the surface area of a cylinder?',
      'answers': [
        'A = 2πr(r + h)',
        'A = l * w',
        'A = πr^2',
        'A = 1/2 * base * height'
      ],
      'correctAnswer': 'A = 2πr(r + h)',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions18 = [
    {
      'question': 'What is the capital of France?',
      'answers': ['Paris', 'London', 'Rome', 'Berlin'],
      'correctAnswer': 'Paris',
      'theme': {'color': Colors.blue},
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'answers': ['Mars', 'Venus', 'Jupiter', 'Saturn'],
      'correctAnswer': 'Mars',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'What is the chemical symbol for water?',
      'answers': ['H2O', 'CO2', 'O2', 'CH4'],
      'correctAnswer': 'H2O',
      'theme': {'color': Colors.orange},
    },
    {
      'question': 'Who wrote "To Kill a Mockingbird"?',
      'answers': [
        'Harper Lee',
        'Mark Twain',
        'Charles Dickens',
        'William Shakespeare'
      ],
      'correctAnswer': 'Harper Lee',
      'theme': {'color': Colors.red},
    },
    {
      'question': 'What is the tallest mammal?',
      'answers': ['Giraffe', 'Elephant', 'Whale', 'Gorilla'],
      'correctAnswer': 'Giraffe',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions19 = [
    {
      'question': 'What is the chemical symbol for carbon?',
      'answers': ['C', 'Ca', 'Co', 'Cu'],
      'correctAnswer': 'C',
      'theme': {'color': Colors.blue},
    },
    {
      'question': 'What is the capital of Japan?',
      'answers': ['Tokyo', 'Kyoto', 'Osaka', 'Seoul'],
      'correctAnswer': 'Tokyo',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'Who painted the Mona Lisa?',
      'answers': [
        'Leonardo da Vinci',
        'Vincent van Gogh',
        'Pablo Picasso',
        'Michelangelo'
      ],
      'correctAnswer': 'Leonardo da Vinci',
      'theme': {'color': Colors.orange},
    },
    {
      'question': 'What is the largest ocean on Earth?',
      'answers': [
        'Pacific Ocean',
        'Atlantic Ocean',
        'Indian Ocean',
        'Arctic Ocean'
      ],
      'correctAnswer': 'Pacific Ocean',
      'theme': {'color': Colors.red},
    },
    {
      'question': 'What is the main component of Earth\'s atmosphere?',
      'answers': ['Nitrogen', 'Oxygen', 'Carbon dioxide', 'Argon'],
      'correctAnswer': 'Nitrogen',
      'theme': {'color': Colors.purple},
    },
  ];

  final List<Map<String, Object>> _questions20 = [
    {
      'question': 'What is the capital of Australia?',
      'answers': ['Canberra', 'Sydney', 'Melbourne', 'Brisbane'],
      'correctAnswer': 'Canberra',
      'theme': {'color': Colors.blue},
    },
    {
      'question': 'Who discovered penicillin?',
      'answers': [
        'Alexander Fleming',
        'Louis Pasteur',
        'Marie Curie',
        'Gregor Mendel'
      ],
      'correctAnswer': 'Alexander Fleming',
      'theme': {'color': Colors.green},
    },
    {
      'question': 'What is the chemical symbol for gold?',
      'answers': ['Au', 'Ag', 'Fe', 'Hg'],
      'correctAnswer': 'Au',
      'theme': {'color': Colors.orange},
    },
    {
      'question': 'Who wrote "Romeo and Juliet"?',
      'answers': [
        'William Shakespeare',
        'Charles Dickens',
        'Jane Austen',
        'Mark Twain'
      ],
      'correctAnswer': 'William Shakespeare',
      'theme': {'color': Colors.red},
    },
    {
      'question': 'What is the largest planet in our solar system?',
      'answers': ['Jupiter', 'Saturn', 'Neptune', 'Uranus'],
      'correctAnswer': 'Jupiter',
      'theme': {'color': Colors.purple},
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    switch (widget.quizType) {
      case 'Phytonquiz':
        _questions = _questions1;
        break;
      case 'Photoshopquiz':
        _questions = _questions2;
        break;
      case 'Unityquiz':
        _questions = _questions3;
        break;
      case 'Sqlquiz':
        _questions = _questions4;
        break;
      case 'Grapicquiz':
        _questions = _questions5;
        break;
      case 'Algebraquiz':
        _questions = _questions6;
        break;
      case 'Linearquiz':
        _questions = _questions7;
        break;
      case 'Ruangquiz':
        _questions = _questions8;
        break;
      case 'Regresiquiz':
        _questions = _questions9;
        break;
      case 'Kecerdasanquiz':
        _questions = _questions10;
        break;
      case 'fisikaquiz':
        _questions = _questions11;
        break;
      case 'Biologyquiz':
        _questions = _questions12;
        break;
      case 'Suhuquiz':
        _questions = _questions13;
        break;
      case 'Sainsquiz':
        _questions = _questions14;
        break;
      case 'Astronomiquiz':
        _questions = _questions15;
        break;
      case 'Elementryquiz':
        _questions = _questions16;
        break;
      case 'advancequiz':
        _questions = _questions17;
        break;
      case 'hardquiz':
        _questions = _questions18;
        break;
      case 'C1quiz':
        _questions = _questions19;
        break;
      case 'nextlvlquiz':
        _questions = _questions20;
        break;
      default:
        _questions = [];
        break;
    }
  }

  void _answerQuestion(String answer) {
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = answer;
      if (answer == _questions[_currentQuestionIndex]['correctAnswer']) {
        _score++;
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showFinalScore(context);
      }
    });
  }

  void _chooseQuestion(int index) {
    setState(() {
      _currentQuestionIndex = index;
    });
  }

  void _showFinalScore(BuildContext context) {
    final scoreProvider = Provider.of<ScoreProvider>(context, listen: false);
    final currentQuiz = widget.title;
    final currentDate = DateTime.now().toLocal().toString().split(' ')[0];
    final questionLength = _questions.length;
    final scoreRatio = _score / questionLength;

    scoreProvider.updateScore(currentQuiz, scoreRatio);
    scoreProvider.addHistory(currentQuiz, currentDate);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text('Your score is $_score out of ${_questions.length}'),
        actions: <Widget>[
          TextButton(
            child: const Text('Back to Home'),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    final questionTheme =
        _questions[_currentQuestionIndex]['theme'] as Map<String, Object>;
    final themeColor = questionTheme['color'] as Color;
    if (_currentQuestionIndex == _questions.length - 1) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: themeColor.withOpacity(0.9),
          shadowColor: themeColor.withOpacity(0.3),
          elevation: 4,
        ),
        onPressed: () {
          _showFinalScore(context);
        },
        child: const Text('Submit',
            style: TextStyle(fontSize: 16.0, color: Colors.white)),
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: themeColor.withOpacity(0.9),
          shadowColor: themeColor.withOpacity(0.3),
          elevation: 4,
        ),
        onPressed: _nextQuestion,
        child: const Text('Next',
            style: TextStyle(fontSize: 16.0, color: Colors.white)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentQuestionIndex + 1) / _questions.length;
    final questionTheme =
        _questions[_currentQuestionIndex]['theme'] as Map<String, Object>;
    final themeColor = questionTheme['color'] as Color;
    final selectedAnswer = _selectedAnswers[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'Copy Link':
                  _copyLink();
                  break;
                case 'Share Link':
                  _shareLink();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Copy Link',
                child: ListTile(
                  leading: Icon(Icons.copy),
                  title: Text('Copy Link'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Share Link',
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share Link'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LinearProgressIndicator(
              value: progress,
              backgroundColor: themeColor.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
            ),
            const SizedBox(height: 16),
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _questions[_currentQuestionIndex]['question'] as String,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...(_questions[_currentQuestionIndex]['answers'] as List<String>)
                .map((answer) {
              final isSelected = selectedAnswer == answer;
              return GestureDetector(
                onTap: () => _answerQuestion(answer),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? themeColor.withOpacity(0.7)
                        : themeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: themeColor),
                  ),
                  child: Text(
                    answer,
                    style: TextStyle(
                      color: isSelected ? Colors.white : themeColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor.withOpacity(0.9),
                    shadowColor: themeColor.withOpacity(0.3),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Previous',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
                _buildBottomButtons(),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50.0,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _chooseQuestion(index),
                      child: Container(
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: index == _currentQuestionIndex
                              ? themeColor.withOpacity(0.9)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: index == _currentQuestionIndex
                                  ? Colors.white
                                  : themeColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
