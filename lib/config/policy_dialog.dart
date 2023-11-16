import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:bin7r4decl/core/constants/colors.dart';

class PolicyDialog extends StatelessWidget {
  PolicyDialog({Key? key, required this.mdFileName})
      : assert(
          mdFileName.contains('.md'),
          'The file must contain the .md extension',
        ),
        super(key: key);

  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.darkGrey,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 300)).then(
                (value) => rootBundle.loadString('assets/$mdFileName'),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) return Markdown(data: snapshot.data!);
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8.0),
                ),
              ),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: const Text(
                "CLOSE",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 32.0),
        ],
      ),
    );
  }
}
