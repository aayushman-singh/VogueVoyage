import 'package:flutter/material.dart';
import 'package:voguevoyage/features/auth_methods.dart';
import 'package:voguevoyage/models/user.dart' as model;
import 'package:voguevoyage/screens/home.dart';
import 'package:voguevoyage/utils/selection.dart';
import 'package:voguevoyage/utils/utils.dart';
import 'package:voguevoyage/utils/user_provider.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  UserPage({super.key});
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _nameController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // Check if arguments are passed
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null) {
        final String name = args['name'];

        _nameController.text = name;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SelectionModel selectionModel = Provider.of<SelectionModel>(context);

    final PageController _pageController = PageController();
    // ignore: unused_local_variable
    int _currentPage = 0;

    void _navigateToNextPage() {
      _pageController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    }

    void _updateUserSelections(SelectionModel selectionModel) {
      selectionModel.updateUserInfo(
        email: selectionModel.email,
        password: selectionModel.password,
        name: selectionModel.name,
        age: selectionModel.age,
        gender: selectionModel.gender,
        bodyTypeOption: selectionModel.bodyTypeOption,
        skinColorOption: selectionModel.skinColorOption,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome!'),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          UserInputPage(
            onContinuePressed: _navigateToNextPage,
            selectionModel: selectionModel,
          ),
          BodyTypeOptions(
            onContinuePressed: _navigateToNextPage,
            selectionModel: selectionModel,
          ),
          SkinColorOptions(
            onSubmitPressed: () {
              _updateUserSelections(selectionModel);
            },
            selectionModel: selectionModel,
          ),
        ],
        onPageChanged: (int page) {
          _currentPage = page;
        },
      ),
    );
  }
}

class UserInputPage extends StatefulWidget {
  final Function onContinuePressed;
  final SelectionModel selectionModel;

  UserInputPage({
    required this.onContinuePressed,
    required this.selectionModel,
  });

  @override
  _UserInputPageState createState() => _UserInputPageState();
}

class _UserInputPageState extends State<UserInputPage> {
  @override
  Widget build(BuildContext context) {
    final selectionModel = widget.selectionModel;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => selectionModel.name = value,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            TextField(
              onChanged: (value) =>
                  selectionModel.age = int.tryParse(value) ?? 0,
              decoration: InputDecoration(labelText: 'Enter your age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Select Gender'),
              value: selectionModel.gender.isNotEmpty
                  ? selectionModel.gender
                  : null,
              onChanged: (String? selectedGender) {
                if (selectedGender != null) {
                  selectionModel.updateUserInfo(gender: selectedGender);
                }
              },
              items: ['male', 'female', 'other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onContinuePressed();
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyTypeOptions extends StatefulWidget {
  final VoidCallback onContinuePressed;
  final SelectionModel selectionModel;

  BodyTypeOptions({
    required this.onContinuePressed,
    required this.selectionModel,
  });

  @override
  _BodyTypeOptionsState createState() => _BodyTypeOptionsState();
}

class _BodyTypeOptionsState extends State<BodyTypeOptions> {
  String? _selectedOption;

  void _updateUserSelection(String selectedOption) {
    widget.selectionModel.bodyTypeOption = selectedOption;
    setState(() {
      _selectedOption = selectedOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Type'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildClickableImage(
                'assets/images/body_type1.png', 'Ectomorph', 'ectomorph'),
            SizedBox(height: 20),
            buildClickableImage(
                'assets/images/body_type2.png', 'Mesomorph', 'mesomorph'),
            SizedBox(height: 20),
            buildClickableImage(
                'assets/images/body_type3.png', 'Endomorph', 'endomorph'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onContinuePressed();
              },
              child: Text('Continue'),
            )
          ],
        ),
      ),
    );
  }

  Widget buildClickableImage(
      String imagePath, String optionText, String optionIndex) {
    bool isSelected = _selectedOption == optionIndex;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _updateUserSelection(optionIndex);
            setState(() {
              _selectedOption = optionIndex;
            });
            print('Selected Body Type: $optionText');
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              border: Border.all(
                  color:
                      isSelected ? Colors.black : Color.fromARGB(255, 0, 0, 0),
                  width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ColorFiltered(
              colorFilter: isSelected
                  ? ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.darken)
                  : ColorFilter.mode(Colors.white, BlendMode.color),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          optionText,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class SkinColorOptions extends StatefulWidget {
  final VoidCallback? onSubmitPressed;
  final SelectionModel? selectionModel;

  SkinColorOptions({
    this.onSubmitPressed,
    this.selectionModel,
  });

  @override
  _SkinColorOptionsState createState() => _SkinColorOptionsState();
}

class _SkinColorOptionsState extends State<SkinColorOptions> {
  String? _selectedOption;
  bool _isLoading = false;
  void _updateUserSelection(String selectedOption) {
    setState(() {
      _selectedOption = selectedOption;
      widget.selectionModel!.skinColorOption = selectedOption;
    });
  }

  void signUpUser(SelectionModel selectionModel) async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: selectionModel.email,
      password: selectionModel.password,
      name: selectionModel.name,
      age: selectionModel.age,
      gender: selectionModel.gender,
      bodyTypeOption: selectionModel.bodyTypeOption,
      skinColorOption: selectionModel.skinColorOption,
    );

    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(initialPage: 1),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skin Undertone'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildClickableImage(
                'assets/images/skin_color1.png', 'Warm', 'warm'),
            SizedBox(height: 20),
            buildClickableImage(
                'assets/images/skin_color2.png', 'Neutral', 'neutral'),
            SizedBox(height: 20),
            buildClickableImage(
                'assets/images/skin_color3.png', 'Cool', 'cool'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_selectedOption != null) {
                  _updateUserSelection(_selectedOption!);
                  print("userinputmain");
                  print(widget.selectionModel?.email);
                  print(widget.selectionModel?.password);
                  print(widget.selectionModel!.name); // Fixed here
                  print(widget.selectionModel!.age); // Fixed here
                  print(widget.selectionModel!.gender); // Fixed here
                  print(widget.selectionModel!.skinColorOption);
                  print(widget.selectionModel!.bodyTypeOption);

                  if (widget.selectionModel!.bodyTypeOption != null &&
                      widget.selectionModel!.skinColorOption != null) {
                    signUpUser(widget.selectionModel!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please complete all selections')));
                  }
                  widget.onSubmitPressed!();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select an option')));
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildClickableImage(
      String imagePath, String optionText, String optionIndex) {
    bool isSelected = _selectedOption == optionIndex;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedOption = optionIndex;
            });
            print('Selected Skin Undertone: $optionText');
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected ? Colors.black : Colors.transparent,
                  width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ColorFiltered(
              colorFilter: isSelected
                  ? ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.darken)
                  : ColorFilter.mode(Colors.white, BlendMode.color),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          optionText,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  void navigateToMain() {
    int? parsedAge = int.tryParse(widget.selectionModel!.age.toString());

    if (parsedAge != null) {
      Navigator.pushReplacementNamed(
        context,
        '/home',
      );
    } else {
      print('Invalid age entered');
    }
  }
}
