import 'package:ajent/app/modules/add_course/add_course_controller.dart';
import 'package:ajent/app/modules/add_course/widgets/AdditionalPage.dart';
import 'package:ajent/app/modules/add_course/widgets/DetailPage.dart';
import 'package:ajent/app/modules/add_course/widgets/OverviewPage.dart';
import 'package:ajent/core/themes/widget_theme.dart';
import 'package:ajent/core/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCoursePage extends StatelessWidget {
  final int pageIndex = Get.arguments;
  final AddCourseController controller =
      Get.put(AddCourseController(Get.arguments));

  var _currentPage = 0.obs;
  PageController _pageController = PageController();
  List<Widget> _page = [
    OverviewPage(),
    DetailPage(),
    AdditionalPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[100],
        toolbarHeight: 70.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          (pageIndex == 1) ? 'Mở lớp (Bạn học)': 'Mở lớp (Bạn dạy)',
          style: GoogleFonts.nunitoSans(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemCount: _page.length,
                  onPageChanged: (index){
                    _currentPage.value = index;
                  },
                  itemBuilder: (context, index){
                    return _page[index];
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(_page.length, (int index){
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 10,
                          width: (index == _currentPage.value) ? 30 : 10,
                          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage.value) ? primaryColor : primaryColor.withOpacity(0.5),
                          ),
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              _pageController.previousPage(duration: Duration(milliseconds: 800), curve: Curves.easeInOutQuint);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: 40,
                              alignment: Alignment.center,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(Icons.navigate_before, color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 100,),
                          InkWell(
                            onTap: (){
                              _pageController.nextPage(duration: Duration(milliseconds: 800), curve: Curves.easeInOutQuint);
                              if (_currentPage == _page.length - 1)
                                {
                                  controller.onAddCourse();
                                }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: 40,
                              alignment: Alignment.center,
                              width: (_currentPage.value == (_page.length - 1)) ? 100 : 40,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: (_currentPage.value == (_page.length - 1)) ?
                                  Obx(() => (controller.isAddingCourse.value) ?
                                  SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                        : Text("Mở lớp", style: GoogleFonts.nunitoSans(color: Colors.white,fontSize: 14, fontWeight: FontWeight.w700),),
                                  )
                                  : Icon(Icons.navigate_next, color: Colors.white,),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            ),
          ),
        ],
      ),
    );
  }
}
