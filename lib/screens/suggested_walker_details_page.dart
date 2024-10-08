import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woodog_app/models/suggested_walker_model.dart';
import 'package:woodog_app/responsive/size_config.dart';
import 'package:woodog_app/services/api_response.dart';
import 'package:woodog_app/services/recruit_walker_service.dart';
import 'package:woodog_app/services/verify_recruit_status_service.dart';
import 'package:woodog_app/utils/constants/color.dart';

class SuggestedWalkerDetailsPage extends StatefulWidget {
  SuggestedWalker suggestedWalkerView;
   SuggestedWalkerDetailsPage({super.key, required this.suggestedWalkerView});

  @override
  State<SuggestedWalkerDetailsPage> createState() => _SuggestedWalkerDetailsPageState();
}

class _SuggestedWalkerDetailsPageState extends State<SuggestedWalkerDetailsPage> {
  bool isRecruited = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  //  isRecruited = widget.walkerView.isRecruited ?? false;
    checkRecruitmentStatus();
  }

  Future<void> checkRecruitmentStatus() async {
    bool recruitedStatus = await checkIfIsRecruited(widget.suggestedWalkerView.id!);

    setState(() {
      isRecruited = recruitedStatus;
    });
  }
  
  Future<void> _recruitWalker() async {
    setState(() {
      isLoading = true;
    });

    ApiResponse response = await recruitWalker(widget.suggestedWalkerView.id!);

    if (response.message == 'Promeneur recruté avec succès') {
      setState(() {
        isRecruited = true;
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Promeneur recruté avec succès !'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message ?? 'Erreur lors du recrutement'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height / 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      widget.suggestedWalkerView.photo_url ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height / 2.2,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.suggestedWalkerView.fullName ?? '',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '5\$/hr',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 16),
                          Text(
                            '10 km',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text('4.4', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(width: 16),
                          Text(
                            '450 walks',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBlackColor.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'About',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              color: kWhiteColor,
                              fontSize: 12.5),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text('Location',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 12.5)),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text('Reviews',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 12.5)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Age', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(
                            '${widget.suggestedWalkerView.age} years',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfigs.screenWidth! * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Experience',
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(
                            '${widget.suggestedWalkerView.monthOfExperience} months',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Alex has loved dogs since childhood. He is currently a veterinary student. Visits the dog shelter we...',
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Text(
                      'Read more',
                      style: TextStyle(
                          color: Colors.amber[900], fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: isRecruited || isLoading ? null : _recruitWalker,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: isRecruited
                              ? const LinearGradient(
                                  colors: [Colors.grey, Colors.grey])
                              : const LinearGradient(
                                  colors: [
                                    Color(0xFFFF7F00),
                                    Color(0xFFFFA726),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                        ),
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                )
                              : Text(
                                  isRecruited ? 'Déjà Recruté' : 'Recruter',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(18),
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child:
                Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Text('Verified',
                      style: TextStyle(
                          color: kWhiteColor, fontWeight: FontWeight.w700)),
                  SizedBox(width: 4),
                  Icon(Icons.check_box_rounded, color: kWhiteColor, size: 16),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
