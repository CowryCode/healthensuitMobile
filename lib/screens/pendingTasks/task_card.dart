import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:healthensuite/utilities/constants.dart';

class TaskCard extends StatefulWidget {
  List<dynamic>? data;
  int? cardIndex;
  bool? isCompleted = false;
  String? taskName = "Task Unavailable";
  Function() onTapCallBack;

  TaskCard({this.data, this.isCompleted, this.taskName, required this.cardIndex, required this.onTapCallBack});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool? isChecked = false;
  String? cardTitle ;
  int? sleepID;
  String? bedTime;
  String? createdDate;
  String? dueDate;
  Color? stripColor;
  late ThemeData themeData;

  @override
  void initState() {
    if(widget.data == null){
      setBasicCardDetails();
    }else{
      setCardDetails(widget.data!, widget.cardIndex!);
    }
    super.initState();
  }

 setCardDetails(List<dynamic> data, int cardIndex){
   DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    sleepID = data[cardIndex]['id'];
    bedTime = data[cardIndex]['bedTime'];
    stripColor = COLOR_PENDING;
    if(bedTime != null){
      stripColor = COLOR_DONE;
      isChecked = true;
    }
    String theDate = data[cardIndex]['date_Created'];
    createdDate = theDate.split('T').first;
    print("This is the created date: $createdDate");
    cardTitle = "Sleep Diary For: $createdDate";
    theDate = dateFormat.parse(createdDate!).add(Duration(days:1)).toString();
    dueDate = "Due on: ${theDate.split(' ').first}";
    print("This is the due date: $dueDate");
 }

 setBasicCardDetails(){
   stripColor = COLOR_PENDING;
   if(widget.isCompleted != null){
     if(widget.isCompleted == true){
       stripColor = COLOR_DONE;
       isChecked = true;
       dueDate = "Completed";
     }else{
       isChecked = false;
       dueDate = "In Progress";
     }
   }else{
     isChecked = false;
     dueDate = "In Progress";
   }
   if(widget.taskName != null){
     cardTitle = widget.taskName;
   }else{
     cardTitle = "Task Unavailable";
   }
 }

  @override
  Widget build(BuildContext context) {
    final sidePad = EdgeInsets.symmetric(horizontal: 10);
    themeData = Theme.of(context);

    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 0,
          color: appItemColorLightGrey,
          child: InkWell(
            onTap: widget.onTapCallBack,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            value: isChecked,
                            onChanged: null,
                            // onChanged: (val) async {
                            //   bool originalState = isChecked;
                            //   setState(() {
                            //     isChecked = val!;
                            //   });
                              // await widget.onCheckedCallback(val!).then((response) {
                              //   if (!response) {
                              //     setState(() {
                              //       isChecked = originalState;
                              //     });
                              //   }
                              // });
                            // },
                          ),
                          Flexible(
                            child: Padding(
                              padding: sidePad,
                              child: Text(
                                cardTitle!,
                                // widget.todoModel.todo,
                                overflow: TextOverflow.ellipsis,
                                style: themeData.textTheme.headline4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                                dueDate!,
                              style: themeData.textTheme.headline5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: stripColor,
                  width: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
