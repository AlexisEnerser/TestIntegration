import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../constants.dart';
import 'IsPhone.dart';

Future<void> showOkAlert({required String title,required String message,required BuildContext context,Function? action}) async {

  bool isMovil = isMobileDevice(MediaQuery.of(context).size.width);
  double height = 300;
  double width= isMovil?MediaQuery.of(context).size.width*0.9:450;
  double borderBox = 20;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PointerInterceptor(
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            height: height,
            width: width,
            child: Stack(
              children: [
                Container(color: Colors.grey.withOpacity(0.05),),
                Center(
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[200]!,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[500]!,
                            blurRadius: 4,
                            offset: const Offset(2, 2), // Shadow position
                          ),
                        ],
                        borderRadius: BorderRadius.circular(borderBox)
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 15,),
                              InkWell(
                                onTap: (){Navigator.of(context).pop(false);},
                                child: const SizedBox(
                                  height: 60,
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_back,color: Colors.white,),
                                      SizedBox(width: 10,),
                                      Text("Regresar",style: TextStyle(color: Colors.white),)
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Image.asset("assets/images/logoBlanco.png",fit: BoxFit.fitHeight,height: 30,),
                              const SizedBox(width: 15,),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: blue1), textAlign: TextAlign.center,),                    
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(message,style: const TextStyle(fontSize: 15,color: Colors.black), textAlign: TextAlign.center,),
                        ),
                        const Spacer(flex: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                                if(action!=null){
                                  action();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                decoration: BoxDecoration(
                                    color: blue1,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Text("Aceptar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}