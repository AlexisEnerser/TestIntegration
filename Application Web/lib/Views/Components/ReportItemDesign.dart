import 'package:flutter/material.dart';

import '../../Models/Reports/ReportApp.dart';
import '../../constants.dart';

class ReportItemDesign extends StatelessWidget {
  final ReportApp data;
  final void Function()? onTap;
  const ReportItemDesign({
    super.key,
    required this.data,
    this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap??(){},
      child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: data.reportTypeId == 1
                      ?dashboardColor
                      :reportColor,
                  width: 2
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Text(data.reportType),
                    const Spacer(),
                    data.isFavorite
                    ?const Icon(Icons.favorite,color: Colors.red,)
                    :const Icon(null),
                    const Spacer(),
                    data.reportTypeId == 1
                        ?Icon(dashboardIcon,color: dashboardColor,)
                        :Icon(reportIcon,color: reportColor,),
                  ],
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 45,
                  width: 180,
                  child: Text(data.name,textAlign: TextAlign.center,),
                ),
                const SizedBox(height: 5,),
              ],
            ),
          )
      ),
    );
  }
}