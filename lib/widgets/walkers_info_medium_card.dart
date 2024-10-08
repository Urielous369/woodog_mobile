import 'package:flutter/material.dart';
import 'package:woodog_app/responsive/size_config.dart';
import 'package:woodog_app/utils/constants/color.dart';

class WalkersInfoMediumCard extends StatefulWidget {
  const WalkersInfoMediumCard({
    super.key,
    required this.image,
    required this.name,
    required this.location,
    required this.press,
  });

  final String image, name, location;
  final VoidCallback press;

  @override
  State<WalkersInfoMediumCard> createState() => _WalkersInfoMediumCardState();
}

class _WalkersInfoMediumCardState extends State<WalkersInfoMediumCard> {
  @override
  Widget build(BuildContext context) {
    SizeConfigs().init(context);
    return InkWell(
      onTap: widget.press,
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.25,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(widget.image, fit: BoxFit.cover),
                  ),
                ),
                 Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6), // Fond semi-transparent
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "4.2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14,),
                        Text(
                          widget.location,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                
                Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 29, 29, 29), // Fond semi-transparent
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("\$3/h", style: TextStyle(color: kWhiteColor),)
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
